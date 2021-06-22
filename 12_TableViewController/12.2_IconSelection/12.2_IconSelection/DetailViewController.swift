//
//  DetailViewController.swift
//  12.2_IconSelection
//
//  Created by Hyoju Son on 2021/06/22.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var lblItem: UILabel!
    var receivedItem: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblItem.text = receivedItem
    }
    
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
