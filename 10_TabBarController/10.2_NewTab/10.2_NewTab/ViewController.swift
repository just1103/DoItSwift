//
//  ViewController.swift
//  10.2_NewTab
//
//  Created by Hyoju Son on 2021/06/14.
//
//  README.md
//  * 10_Tab Bar Controller을 응용함. 기존 project (5_PickerView)를 사용하여 Tab Bar Controller의 탭을 1개 추가


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnMovetoImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnMovetoDatePicker(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }    
}

