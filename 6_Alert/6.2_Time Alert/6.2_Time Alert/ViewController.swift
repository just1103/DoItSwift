//
//  ViewController.swift
//  6.2_Time Alert
//
//  Created by Hyoju Son on 2021/06/06.
//

import UIKit

class ViewController: UIViewController {
    
    let interval = 1.0
    var timeSelector: Selector = #selector(ViewController.updateTime)
    var alarmTime: String = ""
    
    var alertFlag: Bool = false // *Alert를 1분 동안 나타나지 않게 할 변수

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblPickerTime: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        
        let datePickerView = sender
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblPickerTime.text = "선택 시간 : " + formatter.string(from: datePickerView.date)
        
        // 1. 시간 비교 대상 - Date Picker로 선택한 AlarmTime
        formatter.dateFormat = "hh:mm aaa"
        alarmTime = formatter.string(from: datePickerView.date)
        print("alarmTime : " + alarmTime) // 확인용
    }
    
    @objc func updateTime(){
        
        let date = NSDate()

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        lblCurrentTime.text = "현재 시간 : " + formatter.string(from: date as Date)
        
        // 2. 시간 비교 대상 - CurrentTime
        var currentTime: String = ""
        formatter.dateFormat = "hh:mm aaa"
        currentTime = formatter.string(from: date as Date)
        print("currentTime : " + currentTime) // 확인용

        // 3. Timer update에 따라 시간을 비교
        if (alarmTime == currentTime) {
            // view.backgroundColor = UIColor.red // 확인용
            
            if (alertFlag == false ) { // **if문 추가
                let alert = UIAlertController(title: "ALERT", message: "설정한 시간입니다.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "네, 알겠습니다.", style: .default, handler: nil)
                alert.addAction(confirm)
                present(alert, animated: true, completion: nil)
                
                alertFlag = true // **이 때문에 1분 간 시간이 동일해도 Alert가 동작하지 않음
            }
        } else {
            // view.backgroundColor = UIColor.white // 확인용
            
            alertFlag = false // **시간이 지나면 다시 원복
        }
    }
}
