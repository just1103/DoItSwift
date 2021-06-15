//
//  EditViewController.swift
//  11_NavigationController
//
//  Created by Hyoju Son on 2021/06/15.
//

import UIKit

protocol EditDelegate { // 프로토콜 선언 (프로토콜은 메서드를 제시하며, 프로토콜을 Adapt한 객체에서 내용을 구현함)
    func didMessageEditDone(_ controller: EditViewController, message: String) // Edit화면의 데이터를 Main화면으로 전달하기 위함
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
}

class EditViewController: UIViewController {
    @IBOutlet var swIsOn: UISwitch!
    var isOn = false // Edit화면에서 스위치를 직접 제어 불가하므로 변수를 선언
    
    // *EditViewController Class의 textWayValue 프로퍼티
    @IBOutlet var lblWay: UILabel!
    var textWayValue: String = "" // segue way ID에 따라 label에 출력할 텍스트 지정을 위한 변수 (UILabel은 텍스트 직접 제어가 불가하므로) - 왜 불가하게 설계했지??
    
    @IBOutlet var txMessage: UITextField! // Main화면과 동일한 변수명으로 선언한 이유는???
    var textMessage: String = "" // textField에 출력할 텍스트 지정을 위한 변수 (Edit화면에서 직접 UITextField의 텍스트 제어가 불가하므로)
    var delegate: EditDelegate? // 프로토콜을 왜 변수에 할당하지?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblWay.text = textWayValue
        
        txMessage.text = textMessage
        
        swIsOn.isOn = isOn // 현재 변수 isOn 값을 switch.isOn에 대입하여 switch 값에 반영시킴(!!!). 따라서 초기화면의 lamp는 Off (false)상태임
          // (UISwitch).isOn : isOn메서드 - Switch가 On 인 상태를 나타냄
          // 즉 좌측 isOn은 메서드, 우측 isOn은 switch의 상태를 반영한 것??

    }
    
    // 완료 버튼을 터치하면 View가 다시 Main화면으로 이동
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil { // ???
            delegate?.didMessageEditDone(self, message: txMessage.text!) // Edit화면의 textField 데이터를 Main화면으로 전달 (Edit화면의 btnDone 함수에서 didMessageEditDone을 호출하면서, Edit화면의 textField 내용을 메세지 String으로 전달??????)
            delegate?.didImageOnOffDone(self, isOn: isOn) // Edit화면의 switch 상태를 Main화면으로 전달 (Edit화면의 btnDone 함수에서 didMessageEditDone을 호출하면서, Edit화면의 switch 상태를 Main화면의 isOn으로 전달함!
              // 따라서 완료 버튼을 눌러야 switch 상태가 image에 반영됨 (Bar Button으로 복귀하면 switch 값을 반영하지 않음)!
        }
        
        _ = navigationController?.popViewController(animated: true) // Action Segue를 'Show'로 지정했으므로 복귀할 때는 'pop'으로 지정
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn { // switch 상태를 확인하여 isOn 변수에 값을 할당함 (Main 화면에서 이 값을 반영하여 lamp 이미지를 수정)
            isOn = true // switch가 켜져있으면 변수에 true를 할당
        } else {
            isOn = false
        }
    }
    
    
    // Navigation Controller에서 화면 전환을 위해 아래의 prepare 메서드를 사용함 (Main화면의 소스코드인 ViewController.swift 에 작성함)
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
