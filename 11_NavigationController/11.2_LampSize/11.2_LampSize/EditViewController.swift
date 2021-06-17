//
//  EditViewController.swift
//  11.2_LampSize
//
//  Created by Hyoju Son on 2021/06/16.
//

import UIKit

protocol EditDelegate {
    func didEditMessage(_ Controller: EditViewController, message: String)
    func didchangeSwitch(_ Controller: EditViewController, isSwitchOn: Bool)
    func didChangeSize(_ Controller: EditViewController, isBtnZoom: Bool)
}

class EditViewController: UIViewController {

    @IBOutlet var lblSegue: UILabel!
    var editlblSegueText: String = ""
    
    var delegate: EditDelegate?
    @IBOutlet var editTx: UITextField!
    var editText: String = ""
    
    @IBOutlet var mySwitch: UISwitch!
    var isSwitchOn = false
    
    @IBOutlet var btnResize: UIButton! // 버튼 Title을 수정해야 하므로 Outlet 변수로 선언
    var isBtnZoom = false // 초기화면 (Main화면) 이미지가 축소 상태, Edit화면 버튼도 "축소" 상태 (isImgZoom = false, isBtnZoom = false 가정)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblSegue.text = editlblSegueText
        
        editTx.text = editText
        mySwitch.isOn = isSwitchOn
        
        // Main화면의 이미지 크기에 따라 Edit화면의 btnResize title에 반영해야 함
        if isBtnZoom {
            btnResize.setTitle("확대", for: .normal)
        } else {
            btnResize.setTitle("축소", for: .normal)
        } // (왜 예제 2는 안해도 되지? - 초기화면에서 고정되어있음. 예제 11.2는 main화면의 상태를 반영하여 Edit으로 전환할 때 재조정해야 함)
    }
    
    // [Edit => Main]
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil {
            delegate?.didEditMessage(self, message: editTx.text!)
//          delegate?.didEditMessage(self, message: editText) // *오류 발생 - Edit화면의 text가 반영되지 않음 (Edit화면에서 사용자가 텍스트를 입력하면 sender인 UITextField! (editTx.text! 형태)로부터 데이터를 받을 수 있지만, 변수 editText는 초기화면과 동일한 "" 상태이기 때문)

            delegate?.didchangeSwitch(self, isSwitchOn: isSwitchOn)
            delegate?.didChangeSize(self, isBtnZoom: isBtnZoom)
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
        if isBtnZoom { // isBtnZoom == true (확대 버튼인 상태)이면
          btnResize.setTitle("축소", for: .normal)
//        btnResize.setTitle("축소", for: UIControl.State())
        } else {
          btnResize.setTitle("확대", for: .normal)
//        btnResize.setTitle("확대", for: UIControl.State())
        }
        
        isBtnZoom = !isBtnZoom // 반전된 값이 delegate로 넘어감
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
