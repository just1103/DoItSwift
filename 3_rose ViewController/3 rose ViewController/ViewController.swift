//
//  ViewController.swift
//  3 rose ViewController
//
//  Created by Hyoju Son on 2021/04/22.
//
// README.md
// * UIImageView를 활용하여 UIButton (Prev 또는 Next 버튼)을 누르면 image (총 6개)를 변경하는 기능
// * 사용자 편의를 위해 1번 image에서 이전을 누르면 6번으로 이동, 6번 image에서 Next 버튼을 누르면 1번으로 이동하는 기능을 추가


import UIKit

class ViewController: UIViewController {

    var maxImg: Int = 6
    var numImg: Int = 1
    
// var imgName: String = String(numImg) + ".png"
    // 컴파일 에러 발생 - Cannot use instance member 'numImg' within property initializer; property initializers run before 'self' is available -> (*self : imgName을 initialize 하기 위해 numImg를 호출하면 실제로 self.imgName (self=해당 type=class)을 호출하게 되는데, class가 아직 initialize 되지 않은 상태라는 의미)
    // => Solution : Use read-only computed property. (get keyword 생략 가능)
    var imgName: String {
        return String(numImg) + ".png"
    }
    
    @IBOutlet var imgView: UIImageView!
//    @IBOutlet var lblimgBefore: UIButton!  // *필요 없음 - Button 내용 변경 안함 (주석 처리해도 connection이 유지되므로 주의)
//    @IBOutlet var lblimgAfter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        imgView.image = UIImage(named: "1.png")
    }

    @IBAction func imgChangeBefore(_ Sender: UIButton) {
        numImg = numImg - 1
        //if numImg > maxImg { // *증가하는 상황이므로 필요 없음
//            numImg = 1
//        }
        if numImg < 1 {
            numImg = maxImg
        }
        
        imgView.image = UIImage(named: imgName)
    }
    
    @IBAction func imgChangeAfter(_ sender: UIButton) {
        
        numImg = numImg + 1
        if numImg > maxImg {
            numImg = 1
        } //else if numImg < 1 {  // *감소하는 상황이므로 필요 없음
//            numImg = maxImg
//        }

        imgView.image = UIImage(named: imgName)
    }
}

