//
//  ViewController.swift
//  DatePicker
//
//  Created by Hyoju Son on 2021/05/09.
//
// README.md
// * Timer Class (#selector Struct, NSDate Class)를 통해 1초 단위로 정보를 업데이트하며, UILabel에 현재 시간을 나타냄
// * UIDatePicker (DateFormatter Class)를 활용하여 사용자의 선택 시간을 UILabel에 나타냄


import UIKit

class DatePickerforTabBar: UIViewController {

// 타이머 구동 시 실행될 함수 지정 (selector)
    let timeSelector: Selector = #selector(DatePickerforTabBar.updateTime)
    var interval = 1.0
    var count = 0 // 확인용
    
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 타이머 설정
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    // DatePicker 값이 변하면 선택시간 레이블에 출력하는 함수
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "선택 시간 : " + formatter.string(from: datePickerView.date)
    }
    
    // timer에 따라 실행될 함수 (현재시간 정보를 interval마다 가져와서 출력해줌)
    @objc func updateTime(){
//        lblPickerTime.text = String(count) // 확인용
//        count += 1
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
 
        lblCurrentTime.text = "현재 시간 : " + formatter.string(from: date as Date)
    }
    
}

