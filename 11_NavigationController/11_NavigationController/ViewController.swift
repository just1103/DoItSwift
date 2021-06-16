//
//  ViewController.swift
//  11_NavigationController
//
//  Created by Hyoju Son on 2021/06/15.
//
//  README.md
//  * Navigation Controller 및 Segue (prepare 메서드, Delegate protocol)를 활용하여 화면을 전환하면서 데이터를 전달함 (Navigation Controller에 View Control을 Embed 함)
//  * 초기화면 상단의 UIBar Button (Edit Button) 또는 UIButton (수정 Button)을 터치하면, Main화면에서 Edit화면으로 이동하고 Label에 Segue 정보 ("use Bar Button" 또는 "use Button")를 나타냄. 또한 Main화면에서 Message 하단의 TextField에 입력한 텍스트를 Edit화면에서 그대로 보여줌
//  * Edit화면에서 UIButton (완료 Button)을 통해 Main화면으로 재이동함. 마찬가지로 이때 Message 하단의 TextField에 텍스트를 수정하면, Main화면에서 그대로 보여줌. 또한 UISwitch를 터치하여 값을 변경한 경우, Main화면의 Lamp 이미지에 반영함


import UIKit

class ViewController: UIViewController, EditDelegate { // EditViewController에서 선언한 프로토콜을 상속받음
    
    @IBOutlet var mainTx: UITextField!

    @IBOutlet var imgView: UIImageView!
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    var isLampOn = true // Lamp의 on/off를 나타내는 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }

    // [Main => Edit] segue를 통해 화면 전환을 하기 위해 prepare 메서드를 사용 (화면 전환 직전에 호출되며, 데이터 전달 기능이 있음)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // prepare 메서드 - Subclasses override this method. 화면에 표시하기 전에 새로운 View Controller를 구성하기 위함. segue는 화면 전환 (transition)에 관한 정보를 포함함 (2개 View에 대한 reference 등)
                
        let editViewController = segue.destination as! EditViewController // 다음 연결지점(segue.destination)을 EditViewController (Class type)로 캐스팅해서 editViewController 상수에 할당
        
        // segue ID(Identifier)에 따라 다르게 동작하도록 지정
        if segue.identifier == "editButton" { // Button 터치하는 경우
            editViewController.editlblSegueText = "Segue : use Button" // Edit화면의 label 텍스트를 수정
        } else if segue.identifier == "editBarButton" { // Bar Button 터치하는 경우
            editViewController.editlblSegueText = "Segue : use Bar Button"
        }
        
        editViewController.editText = mainTx.text! // Main화면의 텍스트 데이터를 Edit화면으로 전달함
        editViewController.isSwitchOn = isLampOn   // Main화면의 Lamp상태를 Edit화면의 Switch값에 전달함
                  
        editViewController.delegate = self // *EditViewController의 delegate 변수에 self(ViewController)를 할당
    }
    
    // [Edit => Main] Edit화면의 데이터를 Main화면에 전달함 (Edit화면에서 함수가 호출됨) - EditViewController에서 선언한 프로토콜을 conform 하는 함수
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        mainTx.text = message // Edit화면의 message (editTx.text!) 데이터를 Main화면에 전달함
    }
    func didImageOnOffDone(_ controller: EditViewController, isSwitchOn: Bool) {
        if isSwitchOn { // Edit화면의 switch값(mySwitch.isOn)이 true이면, Main화면의 Lamp On/Off에 전달하여 이미지를 변경함
            imgView.image = imgOn
            self.isLampOn = true 
        } else {
            imgView.image = imgOff
            self.isLampOn = false
        }
    }
}
