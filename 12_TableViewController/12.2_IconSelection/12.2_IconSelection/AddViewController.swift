//
//  AddViewController.swift
//  12.2_IconSelection
//
//  Created by Hyoju Son on 2021/06/22.
//
//  README.md
//  * 12_Table View Controller를 응용함. Add View에서 새로운 항목을 추가할 때, Picker View를 통해 사용자가 아이콘을 선택하는 기능을 추가함


import UIKit

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource { // pickerView Delegate 관련 프로토콜 상속

    @IBOutlet var tfAdd: UITextField!
    
    @IBOutlet var myImage: UIImageView!
    @IBOutlet var myPicker: UIPickerView!
    let PICKER_VIEW_COLUMNS = 1
    let PiCKER_VIEW_HEIGHT: CGFloat = 50 // 피커뷰 룰렛의 높이 지정

    var imageArray = [UIImage?]() // UIImage Array를 할당할 변수. *이미지 파일명은 이미 itemsImageFile에 있음
    var chosenImageFileName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< itemsImageFile.count { // 장점 - itemsImageFile 변수에 이미지가 추가되면 자동 반영됨
            let image = UIImage(named: itemsImageFile[i])
            imageArray.append(image)
        }
            
        myImage.image = imageArray[0] // Add View load 시 index 0의 이미지를 보여줌
    }
    
    // 피커뷰의 동작에 필요한 델리게이트 메서드 4개 선언 - column 개수, row 개수, view for row, row height을 지정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMNS
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return itemsImageFile.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageOfRow = UIImageView(image: imageArray[row])
        imageOfRow.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        
        return imageOfRow
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PiCKER_VIEW_HEIGHT
    }
    
    // 피커뷰에서 값을 선택했을 때 할 일을 델리게이트에게 지시하는 메서드 선언
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        myImage.image = imageArray[row]
        
        chosenImageFileName = itemsImageFile[row] // 선택한 이미지의 파일명을 chosenImageFileName 변수에 할당
    }
    
    
    // [Add -> Table] items에 직접 추가하고, Table View로 돌아감
    @IBAction func btnAdd(_ sender: UIButton) {
        
        items.append(tfAdd.text!)
        itemsImageFile.append("\(chosenImageFileName)") // 피커뷰에서 선택한 이미지의 파일명을 전달함
        
        tfAdd.text = ""
        
        _ = navigationController?.popViewController(animated: true)
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
