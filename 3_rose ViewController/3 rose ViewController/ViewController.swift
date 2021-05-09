//
//  ViewController.swift
//  3 rose ViewController
//
//  Created by Hyoju Son on 2021/04/22.
//

import UIKit

class ViewController: UIViewController {

//    var minImg: Int = 1  // *필요 없음 - numImg로 함수 처리 가능
    var maxImg: Int = 6
    var numImg: Int = 1
    
// var imgName: String = String(numImg) + ".png"
    // 컴파일 에러 발생 - 함수 내부에 각각 선언해준다
    // *에러 - Cannot use instance member 'numImg' within property initializer; property initializers run before 'self' is available
    // *self : imgName을 initialize 하기 위해 numImg를 호출하면 실제로 self.imgName (self=해당 type=class)을 호출하게 되는데, class가 아직 initialize 되지 않은 상태라는 의미
    // you cannot use any instance methods nor any instance properties in an initial value of other (usual) instance properties.
    var imgName: String {
        return String(numImg) + ".png"
    }
// => solution : You can use read-only computed property. (get keyworkd 생략 가능)
    
    @IBOutlet var imgView: UIImageView!
//    @IBOutlet var lblimgBefore: UIButton!  // *필요 없음 - Button 내용 변경 안함 (주석 처리해도 connection이 유지되므로 주의)
//    @IBOutlet var lblimgAfter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        img1 = UIImage(named: "1.png")  // *필요 없음
//        img2 = UIImage(named: "2.png")
//        img3 = UIImage(named: "3.png")
//        img4 = UIImage(named: "4.png")
//        img5 = UIImage(named: "5.png")
//        img6 = UIImage(named: "6.png")
        imgView.image = UIImage(named: "1.png")  // 이건 왜 안쓰지?
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

