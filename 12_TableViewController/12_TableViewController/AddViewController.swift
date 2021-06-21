//
//  AddViewController.swift
//  12_TableViewController
//
//  Created by Hyoju Son on 2021/06/19.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet var tfAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // [Add => Table] Add 버튼을 터치했을 때 동작 - Table View에 목록 추가
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!) // 외부변수인 items Array에 textField 내용을 추가
        itemsImageFile.append("clock.png") // 이미지로 무조건 clock.png 파일을 추가 (임의 설정)
        
        tfAddItem.text = "" // textField 입력값을 삭제함
        _ = navigationController?.popViewController(animated: true) // Root View Controller (즉, Table View)로 돌아감
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
