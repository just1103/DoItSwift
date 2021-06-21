//
//  DetailViewController.swift
//  12_TableViewController
//
//  Created by Hyoju Son on 2021/06/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var lblItem: UILabel!
    var receivedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblItem.text = receivedItem // View가 로드되면 해당 텍스트를 표시함
    }
    
    // [Main => Detail] 텍스트 데이터를 넘겨받기 위한 함수 - prepare 함수를 활용함
    func receiveItem (_ item: String) {
        receivedItem = item
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
