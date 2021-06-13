//
//  ViewController.swift
//  9_PageControl
//
//  Created by Hyoju Son on 2021/06/12.
//
// README.md
// * UIPageControl을 활용하여 6개 이미지를 개별 페이지에 나타내고, 하단의 Page Control의 좌측/우측을 터치하면 각각 이전 이미지/다음 페이지로 이동함
// * Page Indicator (미선택 페이지 및 현재 페이지)의 색상을 변경하는 기능을 추가


import UIKit

class ViewController: UIViewController {
    
    // image 파일명 Array를 할당할 변수 선언
    var imageFileName = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

    @IBOutlet var myImgView: UIImageView!
    @IBOutlet var myPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        myPageControl.numberOfPages = imageFileName.count // numberOfPages 프로퍼티 - Page Control의 전체 페이지수를 지정
        myPageControl.currentPage = 0 // 프로퍼티. 초기화면 (현재 페이지)을 0번째 페이지로 지정
        
        myPageControl.pageIndicatorTintColor = UIColor.green // 프로퍼티. Page Indicator 중 미선택 페이지에 대한 dot의 색상을 지정 (defualt-translucent white 반투명 흰색)
        myPageControl.currentPageIndicatorTintColor = UIColor.red // 프로퍼티. Page Indicator 중 현재 페이지에 대한 dot의 색상을 지정 (default-opaque white 불투명 흰색)
        
        myImgView.image = UIImage(named: imageFileName[0])
    }

    // Page Control의 좌측 또는 우측을 터치했을 때 실행할 함수
    @IBAction func pageChange(_ sender: UIPageControl) {
        myImgView.image = UIImage(named: imageFileName[myPageControl.currentPage]) // currentPage 프로퍼티 - Page Control 현재 페이지의 index (Int type)를 가져옴. imageFileName Array의 해당 파일명으로 UIImage type의 이미지를 만들고, image View에 할당함
    }
}
