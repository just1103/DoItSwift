//
//  EditViewController.swift
//  11.2_LampSize
//
//  Created by Hyoju Son on 2021/06/16.
//

import UIKit

protocol EditDelegate {
    func didEditMessage(_ Controller: EditViewController, message: String)
    func didSwitchChange(_ Controller: EditViewController, isSwitchOn: Bool)
}

class EditViewController: UIViewController {

    @IBOutlet var lblSegue: UILabel!
    var editlblSegueText: String = ""
    
    var delegate: EditDelegate?
    @IBOutlet var editTx: UITextField!
    var editText: String = ""
    
    @IBOutlet var mySwitch: UISwitch!
    var isSwitchOn = false
    
    @IBOutlet var btnChangeSize: UIButton!
    var isZoom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblSegue.text = editlblSegueText
        
        editTx.text = editText
        mySwitch.isOn = isSwitchOn
    }
    
    // Edit => Main
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didEditMessage(self, message: editTx.text!)
//          delegate?.didEditMessage(self, message: editText) // *오류 발생 - Edit화면의 text가 반영되지 않음 (Edit화면에서 사용자가 텍스트를 입력하면 sender인 UITextField! (editTx.text! 형태)로부터 데이터를 받을 수 있지만, 변수 editText는 초기화면과 동일한 "" 상태이기 때문)

            delegate?.didSwitchChange(self, isSwitchOn: isSwitchOn)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func switchOnOff(_ sender: UISwitch) {
        if sender.isOn {
            self.isSwitchOn = true
        } else {
            self.isSwitchOn = false
        }
    }
    
    @IBAction func changeSize(_ sender: UIButton) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
