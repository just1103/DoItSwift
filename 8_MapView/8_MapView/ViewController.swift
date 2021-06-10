//
//  ViewController.swift
//  8_MapView
//
//  Created by Hyoju Son on 2021/06/08.
//
// README.md
// * Map View (MKMapView-CLLocationManagerDelegate protocol 상속, CLLocationManager Class 사용 등) 및 UISegmentedControl (총 3개)을 통해 사용자가 Segment를 터치하면 각각 사용자의 현재 위치, 지정 장소1, 지정 장소2를 Map에 나타냄
// * 사용자의 현재 위치가 업데이트 되면 Map을 이동함. 이때 현재 위치의 위도/경도를 활용하여 주소 (국가/지역/도로명)를 구하고, 하단에 텍스트로 나타냄
// * 지정 장소1, 지정 장소2에 핀을 설치하고, 하단에 위치 설명 텍스트를 나타냄. 핀을 터치하면 장소명 (title) 및 주소 (subtitle)를 보여주는 기능을 추가
// * 위도/경도 외에도 범위 (delta span) 수치를 활용하여 Map의 배율을 조정 가능함


import UIKit
import MapKit // MKMapView가 정의되어 있음

class ViewController: UIViewController, CLLocationManagerDelegate { // MapView 사용을 위해 CLLocationManagerDelegate 프로토콜 상속
    
    let constLocationManager = CLLocationManager() // 위치 서비스 제공을 위해 CLLocationManager Class의 instance 선언
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 1. 앱 초기화면에 Map이 나타나도록 함
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        constLocationManager.delegate = self // 상수 locationManager의 delegate를 self로 설정함
        constLocationManager.desiredAccuracy = kCLLocationAccuracyBest // desiredAccuracy 프로퍼티. *kCLLocationAccuracyBest 불변 프로퍼티 (iPhone-default)
        constLocationManager.requestWhenInUseAuthorization() // *requestWhenInUseAuthorization 메서드 - 위치 데이터 추적을 위해 사용자에게 승인 요구
        
        constLocationManager.startUpdatingLocation() // *메서드 - 위치 업데이트를 시작함
        myMap.showsUserLocation = true // 맵뷰를 통해 사용자의 위치 확인이 가능하도록 지정. 프로퍼티
    }

    // 2. 위도/경도, 범위를 parameter로 Map에 원하는 위치를 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D { // setAnnotation 함수를 위해 return값을 추가함
       
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue) // 메서드
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span) // Struct (span이 작을수록 Map이 확대됨. 0.01이면 1보다 Map을 100대 확대한 상태)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue) // Struct
        
        myMap.setRegion(pRegion, animated: true) // 맵뷰를 해당 Region으로 이동. 메서드
        
        return pLocation // setAnnotation 함수를 위해 추가함
    } // 이때 에러가 발생하는 경우 Info.plist>Privacy - Location When In Use Usage Description 추가>value-"App needs location servers." 입력 필요. (console - This app has attempted to access privacy-sensitive data without a usage description.)
    
    // 5. 특정 위도/경도에 핀을 설치하고, 핀을 클릭하면 특정 텍스트를 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        
        let annotation = MKPointAnnotation() // 핀을 설치하기 위해 인스턴스 생성. Class
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span) // annotation 인스턴스의 coordinate(좌표) 값을 goLocation 함수로부터 CLLocationCoordinate2D 형태로 받아야 하는데, 이를 위해 1) goLocation 함수를 수정해야 함 (return type: -> CLLocationCoordinate2D) 또한 2) 해당 함수를 호출한 locationManager 함수를 수정해야 함 (_ = 추가)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        
        myMap.addAnnotation(annotation) // Map에 핀을 추가. 메서드
    }
    
    // 3. 위치가 업데이트 되면 지도에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) { // *[CLLocation]: Array type
        
        let pLocation = locations.last // **업데이트된 위치 중 가장 마지막 값을 받음
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01) // 마지막 값의 위도/경도 및 범위를 통해 goLocation 함수를 호출
            // setAnnotation 함수를 위해 수정함 (_ = 추가)
    
        // 4. (업데이트된 위치의) 위도/경도 값을 추출하여 역으로 주소(국가/지역/도로)를 구하고 Label에 표시
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: { // Handler: {} Closure type
            (placeMarks, error) -> Void in // placeMarks: [CLPlacemark]? type, error: Error? type으로 컴파일러가 이미 알고 있음
            let pm = placeMarks!.first // placeMarks 값의 첫 부분만 할당
            let country = pm!.country // pm의 국가 값을 할당 (CLGeocoder Class의 country 프로퍼티, String? type)
            var address: String = country!
            
            if pm!.locality != nil { // pm에 지역 값이 존재하면 String에 추가 (locality 프로퍼티)
                address += " " + pm!.locality!
            }
            if pm!.thoroughfare != nil { // pm에 도로명 값이 존재하면 String에 추가 (horoughfare 프로퍼티)
                address += " " + pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치 :"
            self.lblLocationInfo2.text = address // label에 주소 String을 표시
        })
        
        constLocationManager.stopUpdatingLocation() // *상수 locationManager, 메서드 - 위치 업데이트를 중지함
    }

    // 6. Segment Control 구현
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // 현재 위치 표시, *사용자의 현재 위치를 업데이트하여 Map에 표시
            
            self.lblLocationInfo1.text = "" // label을 공백으로 초기화해야 기존 텍스트가 삭제됨
            self.lblLocationInfo2.text = ""
            
            constLocationManager.startUpdatingLocation() // *상수 locationManager, startUpdatingLocation 메서드 - 사용자의 현재 위치 정보 업데이트를 시작함
            
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
