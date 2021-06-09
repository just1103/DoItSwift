//
//  ViewController.swift
//  8_MapView
//
//  Created by Hyoju Son on 2021/06/08.
//

import UIKit
import MapKit // MKMapView가 정의되어 있음

class ViewController: UIViewController, CLLocationManagerDelegate { // MapView 사용을 위해 CLLocationManagerDelegate 프로토콜 상속 - The methods that you use to receive events from an associated location manager object. *CL=Core Location
    
    let locationManager = CLLocationManager() // 위치 서비스 제공을 위해 CLLocationManager Class의 instance 선언 - The object (the instances of this class) that you use to start and stop the delivery of location-related events to your app. Assign the delegate before starting any location services.
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
     // 1. 앱 초기화면에 Map이 나타나도록 함
        lblLocationInfo1.text = "" // 왜 이걸 굳이 viewDidLoad 위에 안하고 내부에?
        lblLocationInfo2.text = ""
        
        locationManager.delegate = self // 상수 locationManager의 delegate를 self로 설정함 - The delegate object to receive update events.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // desiredAccuracy 프로퍼티 - The accuracy of the location data that your app wants to receive.
                                                                  // *kCLLocationAccuracyBest 불변 프로퍼티 - The best level of accuracy available. (iPhone default-kCLLocationAccuracyBest. macOS/watchOS/tvOS default-kCLLocationAccuracyHundredMeters.)
        locationManager.requestWhenInUseAuthorization() // ***requestWhenInUseAuthorization 메서드 - 위치 데이터 추적을 위해 사용자에게 승인 요구 (참고-requestAlwaysAuthorization 메서드도 있음)
        
        locationManager.startUpdatingLocation() // *메서드 - 위치 업데이트를 시작함
        myMap.showsUserLocation = true // 맵뷰를 통해 사용자의 위치 확인이 가능하도록 지정. 프로퍼티 - A Boolean value indicating whether the map should try to display the user’s location.
    }

    // 2. 위도/경도, 범위를 parameter로 Map에 원하는 위치를 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D { // CLLocationDegrees & CLLocationDegrees는 Double의 typealias
       
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 메서드 - Formats a latitude/longitude value into a coordinate structure(좌표 구조).
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // Struct - The width/height of a map region. (span이 작을수록 Map이 확대됨. 0.01이면 1보다 Map을 100대 확대한 상태)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // Struct - A rectangular geographic region centered around a specific latitude/longitude.
        
        myMap.setRegion(pRegion, animated: true) // 맵뷰를 해당 Region으로 이동. 메서드 - Changes the currently visible region and optionally animates the change.
        
        return pLocation // setAnnotation 함수를 위해 추가함
    } // 이때 에러가 발생하는 경우 Info.plist>Privacy - Location When In Use Usage Description 추가>value-"App needs location servers." 입력 필요. (console - This app has attempted to access privacy-sensitive data without a usage description.)
    
    // 5. 특정 위도/경도에 핀을 설치하고, 핀을 클릭하면 특정 텍스트를 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        
        let annotation = MKPointAnnotation() // 핀을 설치하기 위해 인스턴스 생성. Class - A string-based annotation that you apply to a specific map point.
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // annotation 인스턴스의 coordinate(좌표) 값을 goLocation 함수로부터 CLLocationCoordinate2D 형태로 받아야 하는데, 이를 위해 1) goLocation 함수를 수정해야 함 (return type: -> CLLocationCoordinate2D, 함수 선언부 마지막 return pLocation) 또한 2) 해당 함수를 호출한 locationManager 함수 부분을 수정해야 함 (goLocation 함수를 호출했으나 return 값을 사용하지 않으므로 앞에 _ = 추가)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        
        myMap.addAnnotation(annotation) // Map에 핀을 추가. 메서드 - Adds the specified annotation to the map view.
    }
    
    // 3. 위치가 업데이트 되면 지도에 표시 (Tells the delegate that new location data is available.) // 이 함수는 어디서 호출된거지???? 상수만 쓰인것 같은데...
        // let locationManager 상수가 있는데 함수명을 동일하게 하는게 좋은 방법인가?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // *[CLLocation]: Array type
        
        let pLocation = locations.last // **업데이트된 위치 중 가장 마지막 값을 받음
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 값의 위도/경도 및 범위를 통해 goLocation 함수를 호출
            // setAnnotation 함수를 위해 수정함 (_ = 추가) (에러메시지-Result of call to 'goLocation' is unused.) -> return 값을 안쓰려면 무조건 _ = 만 추가하면 되나??
    
        // 4. (업데이트된 위치의) 위도/경도 값을 추출하여 역으로 주소(국가/지역/도로)를 구하고 Label에 표시
           // CLGeocoder Class - An interface for converting between geographic coordinates and place names.
           // reverseGeocodeLocation 메서드 - Submits a reverse-geocoding request for the specified location.
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: { // Handler: {} Closure type
            (placeMarks, error) -> Void in // placeMarks: [CLPlacemark]? type, error: Error? type으로 컴파일러가 이미 알고 있음
            let pm = placeMarks!.first // placeMarks 값의 첫 부분만 할당 (placeMarks는 Array type) // 왜 pLocation 처럼 .Last가 아니지??
            let country = pm!.country // pm의 국가 값을 할당 (CLGeocoder Class의 country 프로퍼티, String? type)
            var address: String = country!
            
            if pm!.locality != nil { // pm에 지역 값이 존재하면 String에 추가 (CLGeocoder Class의 locality 프로퍼티)
                address += " " + pm!.locality!
            }
            if pm!.thoroughfare != nil { // pm에 도로명 값이 존재하면 String에 추가 (CLGeocoder Class의 thoroughfare 프로퍼티)
                address += " " + pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치 :"
            self.lblLocationInfo2.text = address // label에 주소 String을 표시
        })
        
        locationManager.stopUpdatingLocation() // *상수 locationManager, 메서드 - 위치 업데이트를 중지함
    }

    // 6. Segment Control 구현
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 { // sender.selectedSegmentIndex 값 == 0/1/2에 따라 segment를 구분
            // 현재 위치 표시, *사용자의 현재 위치를 업데이트하여 Map에 표시
            
            self.lblLocationInfo1.text = "" // label을 공백으로 초기화해야 기존 텍스트가 삭제됨
            self.lblLocationInfo2.text = ""
            
            locationManager.startUpdatingLocation() // *상수 locationManager ???, startUpdatingLocation 메서드 - 사용자의 현재 위치 정보 업데이트를 시작함
            
        } else if sender.selectedSegmentIndex == 1 {
            // 폴리텍대학 표시, 해당 위치에 핀 설치
            setAnnotation(latitudeValue: 37.73730826440487, longitudeValue: 128.89025099742645, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            
            self.lblLocationInfo1.text = "지정한 위치 :"
            self.lblLocationInfo2.text = "한국폴리텍대학 강릉캠퍼스"
            
        } else if sender.selectedSegmentIndex == 2 {
            // 이지스퍼블리싱 표시, 해당 위치에 핀 설치
            setAnnotation(latitudeValue: 37.55668892216729, longitudeValue: 126.91407639742123, delta: 1, title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스빌딩")
            
            self.lblLocationInfo1.text = "지정한 위치 : "
            self.lblLocationInfo2.text = "서울 이지스퍼블리싱 출판사"
        }
    }
}
