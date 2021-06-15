//
//  ViewController.swift
//  11_NavigationController
//
//  Created by Hyoju Son on 2021/06/15.
//

import UIKit

class ViewController: UIViewController, EditDelegate { // EditViewController에서 선언한 프로토콜을 상속받음
    @IBOutlet var imgView: UIImageView!
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    var isOn = true // lamp가 On 상태인지 나타내는 변수 (-> imgView.image를 통해 이미지 할당에 반영함)
    
    @IBOutlet var txMessage: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgView.image = imgOn
    }

    // Segue로 연결된 EditViewController 화면의 Label을 수정
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { // segue way로 화면 전환을 하기 위해 prepare 메서드를 사용 (화면 전환 직전에 호출되며, 데이터 전달 기능이 있음)
        
        // segue의 destination인 EditViewController Class type의 View Controller를 상수 editViewController에 할당 (교재 - segue way의 '도착 View Controller'를 EditViewController Class type의 segue.destination ViewController로 선언함 ????????)
        let editViewController = segue.destination as! EditViewController // destination 프로퍼티
          // editViewController 상수가 EditViewController Class와 연관된 걸 어떻게 알지????
        
        // segue way ID(Identifier)에 따라 다르게 동작하도록 지정
        if segue.identifier == "editButton" { // Button 터치하는 경우
            editViewController.textWayValue = "Segue : use Button" // Edit화면의 label 텍스트를 수정 (*EditViewController Class의 textWayValue 프로퍼티를 사용하는 경우 이렇게 작성)
        } else if segue.identifier == "editBarButton" { // Bar Button 터치하는 경우
            editViewController.textWayValue = "Segue : use Bar Button"
        }
        
        editViewController.textMessage = txMessage.text!
        
        editViewController.isOn = isOn // prepare 메서드에서 Main화면의 상태를 -> Edit화면의 isOn에 할당함 (즉, 초기상태에서 true, lamp가 On인 상태를 나타냄 -> switch도 On으로 지정함)
                  
        editViewController.delegate = self // ????
    }
    
    // EditViewController에서 선언한 프로토콜을 conform 하는 함수. Edit화면의 데이터를 Main화면에 전달하여 보여줌 (EditViewController에서 이 함수를 호출하면 메세지를 전달해줌. 이 메세지의 String 값을 Main화면의 textField에 텍스트로 보여줌)
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn { // Edit화면의 switch값(.isOn)을 Main화면(isOn)에 전달하여 lamp 이미지를 수정함
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }

}

