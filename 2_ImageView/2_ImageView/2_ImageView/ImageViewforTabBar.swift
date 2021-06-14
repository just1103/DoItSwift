//
//  ViewController.swift
//  2 ImageView
//
//  Created by Hyoju Son on 2021/04/22.
//
// README.md
// * UIImageView를 활용하여 UIButton을 누르면 image를 확대/축소하고, UISwitch를 누르면 image를 변경함


import UIKit

class ImageViewforTabBar: UIViewController {
    
    var isZoom = false   // 이미지 확대 여부를 나타내는 Bool type 변수 (false = 축소 상태로 가정함)
    var imgOn: UIImage?  // 켜진 전구 이미지가 있는 UIImage type의 변수
    var imgOff: UIImage? // 꺼진 전구 이미지가 있는 UIImage type의 변수
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgOn = UIImage(named: "lamp_on.png")   // UIImage 타입의 변수 imgOn에 "" 이미지를 할당
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn  // Outlet 변수 imgView에다가 imgOn 이미지를 지정
    }

    // 확대-축소 버튼에 대한 Action 함수
    @IBAction func btnResizeImage(_ sender: UIButton) {
        
        let scale: CGFloat = 2.0 // 이미지를 확대할 배율값 *CGFloat : Core Graphics에서 재정의한 Float data type
        var newWidth: CGFloat, newHeight: CGFloat // 확대 또는 축소 후의 이미지 가로세로 길이값

        if isZoom { // isZoom == true (확대 상태) 인 경우 1) isZoom의 현재 상태에 따라 수행할 작업을 if 문으로 구성
            newWidth = imgView.frame.width / scale  // *.frame.width : 이미지의 사각형은 .frame, 가로는 .width
            newHeight = imgView.frame.height / scale
            btnResize.setTitle("확대", for: .normal)
        } else { // isZoom == false (축소 상태) 인 경우
            newWidth = imgView.frame.width * scale
            newHeight = imgView.frame.height * scale
            btnResize.setTitle("축소", for: .normal)
        }
        isZoom = !isZoom // 2) 해당 작업을 마치면 isZoom의 상태를 반전시켜줌
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)  // 3) CGSize 메서드를 사용해 이미지 뷰의 frame 크기를 변경함 (변경 안하면 사진 크기가 고정됨)
    }
    
    // On-Off Switch에 대한 Action 함수
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if sender.isOn {  // *.isOn : Switch가 On 인 상태를 나타냄
            imgView.image = imgOn // 만약 On 이면 imgOn (켜진 전구 이미지)를 할당
        } else {
            imgView.image = imgOff
        }
    }
}

