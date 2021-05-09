//
//  ViewController.swift
//  1 HelloWorld
//
//  Created by Hyoju Son on 2021/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var lblHello: UILabel!  // 출력 label용 Outlet Variable
    
    @IBOutlet var txtname: UITextField!  // 이름 입력용 Outlet Variable
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSend(_ sender: UIButton) {
        lblHello.text = "Hello, " + txtname.text!  // String ""과 txtname.text를 결합하여 lblHello.txt!에 할당 (!:강제 unwrapping)
    }
    
}

