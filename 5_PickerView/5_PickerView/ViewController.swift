//
//  ViewController.swift
//  5_PickerView
//
//  Created by Hyoju Son on 2021/05/17.
//
// README.md
// * UIPickerView를 활용 (UIPickerViewDelegate Class 상속, Delegate 메서드 사용)하여 사용자가 룰렛에서 선택한 값을 UILabel 및 UIImageView를 통해 파일명 및 image로 나타냄
// * PickerView의 룰렛에 파일명 (옵션1) 또는 image (옵션2)를 나타냄


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    // *참고-command + 마우스 커서 UIPickerViewDelegate > Jump to Definition 하면 해당 Class의 메서드 정의 창으로 이동함
    let MAX_ARRAY_NUM = 10 // 이미지의 파일명을 저장할 배열의 최대 크기
    let PICKER_VIEW_COLUMNS = 1 // 피커뷰 column의 개수
    let PiCKER_VIEW_HEIGHT: CGFloat = 80 // 옵션2) 피커뷰 룰렛의 높이 지정
    
    var imageArray = [UIImage?]() // *Empty Array 선언 (UIImage type의 Array를 저장할 변수 imageArray 선언)
    var imageFileName = [ "1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg", "7.jpg", "8.jpg", "9.jpg", "10.jpg" ] // 이미지 파일명을 저장한 Array
    
    @IBOutlet var pickerImage: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUM { // 0이상 10미만 // 변수 선언부가 아니라 왜 여기서 선언하지? -> [for문 실행 시점=함수를 호출할 때]이므로 함수 선언부에 넣는 게 맞음
            let image = UIImage(named: imageFileName[i]) // UIImage type의 변수 선언, imageFileName Array의 이미지를 변수에 할당
            imageArray.append(image) // Empty Array에 하나씩 추가함
        }
        
        // label, 이미지뷰에 배열의 초기값을 할당
        lblImageFileName.text = imageFileName[0] // String type 이므로 .text
        imageView.image = imageArray[0] // UIImage type 이므로 .image
    }

 // 피커뷰의 동작에 필요한 델리게이트 메서드 3개 선언 - column 개수, row 개수, 옵션1)row title, 옵션2)row image를 지정 (ViewController Class에 선언되어있는 메서드임)
    // Returns the number of columns to display
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMNS
    } // 피커뷰에게 컴포넌트(column)의 개수를 int 값으로 넘겨주는 델리게이트 메서드 (이 경우 column을 1개로 지정)

    // Returns the number of rows in each column
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    } // numberOfRowsInComponent 인수를 가지는 델리게이트 메서드. 피커뷰에게 컴포넌트(column)의 개수를 int 값으로 넘겨줌 (즉, 피커뷰 해당 column에서 선택 가능한 row의 개수(데이터 개수)를 의미함. 이 경우 Array imageFileNumber의 개수인 10을 넘겨줌)
    
//    // 옵션1) Returns the title of each row (이 메서드가 없으면 피커뷰의 row가 모두 "?"로 뜸)
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return imageFileName[row] // Array[row]
//    } // titleForRow 인수를 가지는 델리게이트 메서드. 피커뷰에게 컴포넌트 (column)의 row title을 String 값으로 넘겨줌 (이 경우 imageFileName에 저장된 파일명을 넘겨줌)
    
    // 옵션2) Returns the view of rows in each column
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let imageOfRow = UIImageView(image: imageArray[row]) // *UIImage-named가 아니라 Class UIImageView-image. 선택된 row의 이미지를 가져옴
        imageOfRow.frame = CGRect(x: 0, y: 0, width: 100, height: 150) // Struct CGRect (rectangle 관련 정보). imageView의 frame size 지정
        
        return imageOfRow
    } // viewForRow 인수를 가지는 델리게이트 메서드. 룰렛에 파일명 대신 이미지를 넣을 때 사용
    
    // 옵션2-2) Returns height of row for each column
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return PiCKER_VIEW_HEIGHT
    } // rowHeightForComponent 인수를 가지는 델리게이트 메서드. 피커뷰 룰렛의 높이 지정

    
 // 피커뷰에서 값을 선택했을 때 할 일을 델리게이트에게 지시하는 메서드 선언
    // 피커뷰에서 선택한 값 (이미지 파일명)을 label에 출력함 (참고-@IBAction은 label 불가, button만 가능)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text = imageFileName[row] // 이 경우 Array에서 index-row에 해당하는 String을 가져와 label text에 저장함
        imageView.image = imageArray[row] // index-row에 해당하는 이미지를 가져옴
    } // 피커뷰 델리게이트 메서드 중 didSelectRow 인수가 포함된 메서드는 사용자가 피커뷰 값을 선택했을 때 호출됨. 사용자가 선택한 row 정보를 사용하여 코딩함
}

