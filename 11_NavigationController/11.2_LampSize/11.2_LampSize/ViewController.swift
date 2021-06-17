//
//  ViewController.swift
//  11.2_LampSize
//
//  Created by Hyoju Son on 2021/06/16.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    @IBOutlet var mainTx: UITextField!
//    var mainText: String = "" // 필요 없음
    
    @IBOutlet var imgView: UIImageView!
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    var isLampOn = true
    
    var isImgZoom = false // 초기화면의 이미지는 축소 상태
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        mainTx.text = mainText // 필요 없음 (초기화면에서 blank 상태이므로)
        
        imgView.image = imgOn
    }

    // [Main => Edit] - Edit화면으로 전환되면서 호출됨
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let editViewController = segue.destination as! EditViewController
        
        if segue.identifier == "sgButton" {
            editViewController.editlblSegueText = "Segue : use Button"
        } else if segue.identifier == "sgBarButton" {
            editViewController.editlblSegueText = "Segue : use Bar Button"
        }
        
        editViewController.editText = mainTx.text!
        editViewController.isSwitchOn = isLampOn
        
        editViewController.isBtnZoom = isImgZoom
        // 1) 초기화면 (Main화면) 이미지가 축소 상태, Edit화면 버튼도 "축소" 상태 (isImgZoom = false, isBtnZoom = false)
        // 2) 다시 Edit화면으로 전환하는 경우, 변경된 isImgZoom을 Edit화면의 isBtnZoom 변수에 반영함
        
        editViewController.delegate = self
    }

    // [Edit => Main]
    func didEditMessage(_ Controller: EditViewController, message: String) {
        mainTx.text = message
    }
    func didchangeSwitch(_ Controller: EditViewController, isSwitchOn: Bool) {
        if isSwitchOn {
            imgView.image = imgOn
            self.isLampOn = true
        } else {
            imgView.image = imgOff
            self.isLampOn = false
        }
    }
    func didChangeSize(_ Controller: EditViewController, isBtnZoom: Bool) {
        
        if isImgZoom == isBtnZoom { // !!! Main화면 이미지가 이미 확대된 경우, Edit에서 확대버튼을 눌러도 반응 없어야 함
            return
        }
        
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isBtnZoom { // isBtnZoom == true (Edit화면에서 버튼이 축소->확대로 변경됐으면, 이미지를 확대시켜줌)
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
        } else {
            newWidth = imgView.frame.width / scale
            newHeight = imgView.frame.height / scale
        }

        isImgZoom = !isImgZoom
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
    
        
        // 이렇게만 하면 Edit에서 btzResize를 터치하지 않아도 이미지 크기가 변경됨!!!
//        if isBtnZoom {
//            newWidth = imgView.frame.width / scale
//            newHeight = imgView.frame.height / scale
//        } else {
//            newWidth = imgView.frame.width * scale
//            newHeight = imgView.frame.height * scale
//        }
//
//        self.isImgZoom = !isImgZoom
//        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
    }
}

