//
//  ViewController.swift
//  DatePicker
//
//  Created by Hyoju Son on 2021/05/09.
//

import UIKit

class ViewController: UIViewController {

// 타이머 구동 시 실행될 함수 지정 (selector)
    let timeSelector: Selector = #selector(ViewController.updateTime)
    var interval = 1.0
    var count = 0
    
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
//        lblPickerTime.text = String(count)
//        count += 1
        
        let date = NSDate()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
 
        lblCurrentTime.text = "현재 시간 : " + formatter.string(from: date as Date)
    }
    
}

