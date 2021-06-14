//
//  ViewController.swift
//  10_TabBarController
//
//  Created by Hyoju Son on 2021/06/14.
//
//  README.md
//  * Tab Bar Controller를 활용하여 하나의 앱에서 여러 화면 (View Controller)을 나타냄. (Tab Bar Controller에 View Control을 Embed 함)
//  * 하단의 3개 탭을 터치하면 각각 다른 화면을 보여주며, 두번째 및 세번째 탭은 기존에 만든 project (2_ImageView 및 4_DatePicker)를 활용함. 기존 project의 storyboard의 View Controller 및 swift 파일 (소스코드)를 그대로 사용함
//  * 초기화면 (첫번째 탭) 상단의 UIButton을 통해 두번째 및 세번째 화면으로 이동하는 기능을 추가


import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // 초기화면 상단의 2개 버튼을 터치하면 View를 전환 (Tab Bar 두번째, 세번째 버튼을 터치하는 것과 동일한 기능)
    @IBAction func btnMovetoImageView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 1 // index 0/1/2는 각각 초기화면/이미지뷰/데이트피커뷰 View를 가르킴
        // 1) tabBarController 프로퍼티 - Optional UITabBarController type이므로 unwrap 필요. *View Controller is embedded inside a Tab Bar Controller인 경우(즉, view controller가 tab bar controller의 자식 항목) 이 프로퍼티는 nil이 아님
        // 2) selectedIndex 프로퍼티 - 현재 선택된 Tab Bar Item에 해당하는 View Controller의 index (Int type)
    }
    
    @IBAction func btnMovetoDatePickerView(_ sender: UIButton) {
        tabBarController?.selectedIndex = 2
    }
}

