//
//  ViewController.swift
//  5.2_multiCompPickerView
//
//  Created by Hyoju Son on 2021/06/04.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let PICKER_VIEW_COLUMNS = 2 // *multi-Column으로 구현
    let MAX_ARRAY_NUM = 10
    let PICKER_VIEW_HEIGHT: CGFloat = 80 // 옵션2
    
    var imageArray = [UIImage?]()
    var imageFileNameArray = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg" ]

    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileNameArray[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileNameArray[0]
        imageView.image = imageArray[0]
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMNS
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileNameArray.count
    }
    
    // 옵션1
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileNameArray[row]
//    }
    
    // 옵션2
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageOfRow = UIImageView(image: imageArray[row])
        imageOfRow.frame = CGRect(x: 0, y: 0, width: 100, height: 150)
        
        return imageOfRow
    }
    
    // 옵션2
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PICKER_VIEW_HEIGHT
    }
    
    // *column별 개별 동작하도록 지정 (col.0-lbl 변경, col.1-imageView 변경)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (component == 0) {
            lblImageFileName.text = imageFileNameArray[row]
        } else {
            imageView.image = imageArray[row]
        }
        
    }
}

