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
    
    var isImgZoom = false
    
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
        
        editViewController.delegate = self
    }

    // [Edit => Main]
    func didEditMessage(_ Controller: EditViewController, message: String) {
        mainTx.text = message
    }
    func didSwitchChange(_ Controller: EditViewController, isSwitchOn: Bool) {
        if isSwitchOn {
            imgView.image = imgOn
            self.isLampOn = true
        } else {
            imgView.image = imgOff
            self.isLampOn = false
        }
    }
}

