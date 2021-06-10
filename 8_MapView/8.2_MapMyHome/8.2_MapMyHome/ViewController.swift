//
//  ViewController.swift
//  8.2_MapMyHome
//
//  Created by Hyoju Son on 2021/06/10.
//
// README.md
// * 8_MapView를 응용함. Segment를 추가하여 My Home에 핀을 설치함

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    let constLocationManager = CLLocationManager()
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 앱 초기화면에 Map이 나타나도록 함
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        constLocationManager.delegate = self
        constLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        constLocationManager.requestWhenInUseAuthorization()
        
        constLocationManager.startUpdatingLocation()
        
        myMap.showsUserLocation = true
    }
    
    // 위도/경도, 범위를 parameter로 Map에 원하는 위치를 표시
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        
        let pLocation = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }
    
    // 특정 위도/경도에 핀을 설치하고, 핀을 클릭하면 특정 텍스트를 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        
        myMap.addAnnotation(annotation)
    }
    
    // 위치가 업데이트 되면 지도에 표시
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        // (업데이트된 위치의) 위도/경도 값을 추출하여 역으로 주소(국가/지역/도로)를 구하고 Label에 표시
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placeMarks, error) -> Void in
            let pm = placeMarks!.first
            let country = pm!.country
            var address: String = country!
            
            if pm!.locality != nil {
                address += " " + pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " " + pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치 :"
            self.lblLocationInfo2.text = address
        })
        
        constLocationManager.stopUpdatingLocation()
    }
    
    // Segment Control 구현
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            // 현재 위치
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
           
            constLocationManager.startUpdatingLocation()
            
        } else if sender.selectedSegmentIndex == 1 {
            // 폴리텍대학 표시, 해당 위치에 핀 설치
            setAnnotation(latitudeValue: 37.73730826440487, longitudeValue: 128.89025099742645, delta: 0.1,
                                                    title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            
            self.lblLocationInfo1.text = "지정 위치 :"
            self.lblLocationInfo2.text = "한국폴리텍대학 강릉캠퍼스"

        } else if sender.selectedSegmentIndex == 2 {
            // 이지스퍼블리싱 표시, 해당 위치에 핀 설치
            setAnnotation(latitudeValue: 37.55668892216729, longitudeValue: 126.91407639742123, delta: 0.1,
                                                    title: "이지스퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스빌딩")
            
            self.lblLocationInfo1.text = "지정 위치 : "
            self.lblLocationInfo2.text = "서울 이지스퍼블리싱 출판사"
        } else if sender.selectedSegmentIndex == 3 {
            // MyHome 표시, 해당 위치에 핀 설치
            setAnnotation(latitudeValue: 37.42049627925402, longitudeValue: 127.12672337275986, delta: 0.1,
                                                    title: "My Home", subtitle: "경기도 성남시 중원구 성남대로 997")
            
            self.lblLocationInfo1.text = "지정 위치 : "
            self.lblLocationInfo2.text = "My Home - 성남시청"
        }
    }
}

