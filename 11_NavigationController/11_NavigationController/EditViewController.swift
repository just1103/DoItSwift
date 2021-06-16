//
//  EditViewController.swift
//  11_NavigationController
//
//  Created by Hyoju Son on 2021/06/15.
//
//  README.md
//  * Navigation Controller 및 Segue (prepare 메서드, Delegate protocol)를 활용하여 화면을 전환하면서 데이터를 전달함 (Navigation Controller에 View Control을 Embed 함)
//  * 초기화면 상단의 UIBar Button (Edit Button) 또는 UIButton (수정 Button)을 터치하면, Main화면에서 Edit화면으로 이동하고 Label에 Segue 정보 ("use Bar Button" 또는 "use Button")를 나타냄. 또한 Main화면에서 Message 하단의 TextField에 입력한 텍스트를 Edit화면에서 그대로 보여줌
//  * Edit화면에서 UIButton (완료 Button)을 통해 Main화면으로 재이동함. 마찬가지로 이때 Message 하단의 TextField에 텍스트를 수정하면, Main화면에서 그대로 보여줌. 또한 UISwitch를 터치하여 값을 변경한 경우, Main화면의 Lamp 이미지에 반영함


import UIKit

protocol EditDelegate { // 프로토콜 선언
    func didMessageEditDone(_ controller: EditViewController, message: String) // Edit화면에서 입력한 데이터를 Main화면으로 전달 (textField에 반영하기 위함)
    func didImageOnOffDone(_ controller: EditViewController, isSwitchOn: Bool) // 마찬가지로 Edit화면의 switch값 데이터를 Main화면으로 전달 (Lamp상태에 반영하기 위함)
}

class EditViewController: UIViewController {
    
    @IBOutlet var lblSegue: UILabel!
    var editlblSegueText: String = "" // segue ID에 따라 label에 출력할 텍스트 지정을 위한 변수 (UILabel은 텍스트 직접 제어가 불가하므로)
    
    @IBOutlet var editTx: UITextField!
    var editText: String = ""   // textField에 출력할 텍스트 지정을 위한 변수 (Edit화면에서 직접 UITextField의 텍스트 제어가 불가하므로)
    var delegate: EditDelegate? // 프로토콜을 변수에 할당

    @IBOutlet var mySwitch: UISwitch!
    var isSwitchOn = false // Edit화면의 switch값을 제어하기 위한 변수 (switch값이 on/off인지 확인하는 기존의 .isOn 프로퍼티 (true/false)와 구분됨)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblSegue.text = editlblSegueText
        
        editTx.text = editText
        mySwitch.isOn = isSwitchOn // switch값 (isOn 프로퍼티로 접근)을 isSwitchOnNow 변수로 제어함
    }
    
    // [Edit => Main] 완료 버튼을 터치했을 때
    @IBAction func btnDone(_ sender: UIButton) {

        // 1) ViewController에서 선언한 didMessageEditDone 함수를 여기서 호출함 (Edit화면의 데이터를 Main화면으로 전달)
        if delegate != nil { // *Main화면에서 넘어온 경우, delegate는 ViewController가 할당되어 nil이 아님
            delegate?.didMessageEditDone(self, message: editTx.text!)
            delegate?.didImageOnOffDone(self, isSwitchOn: isSwitchOn) // Edit화면의 switch값을 Main화면의 Lamp On/Off에 전달하기 위함 (완료 버튼을 누를 때 호출하도록 구현. 따라서 Bar Button으로 복귀하면 switch 값을 반영하지 않음)
        }
        
        // 2) Main화면으로 이동
        _ = navigationController?.popViewController(animated: true) // popViewController 메서드 - stack에 쌓여있는 이전 ViewController (부모 View)로 이동
    }
    
    // switch 값 변경에 따라 Lamp On/Off에 전달
    @IBAction func switchOnOff(_ sender: UISwitch) {
        if sender.isOn { // switch값이 On(true)이면, Main화면의 Lamp를 On함
            isSwitchOn = true 
        } else {
            isSwitchOn = false
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
