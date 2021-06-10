//
//  ViewController.swift
//  1 HelloWorld
//
//  Created by Hyoju Son on 2021/04/21.
//
// README.md
// *UITextField에 사용자가 값을 입력하고 UIButton을 누르면, UILabel에 "Hello, 입력값"을 출력함


import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblHello: UILabel!  // 출력 label용 Outlet Variable
    @IBOutlet var txtname: UITextField!  // 이름 입력용 Outlet Variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "Hello, " + txtname.text!  // String "Hello, "와 txtname.text를 합쳐 lblHello.txt에 할당 (!:Forced unwrapping)
    }
}

