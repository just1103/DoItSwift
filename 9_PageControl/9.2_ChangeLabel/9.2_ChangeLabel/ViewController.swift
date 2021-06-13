//
//  ViewController.swift
//  9.2_ChangeLabel
//
//  Created by Hyoju Son on 2021/06/13.
//
//  README.md
//  * 9_Page Control을 응용함. UIPageControl 및 UILabel을 활용하여 화면에 페이지 번호 (1~10)를 표시함


import UIKit

class ViewController: UIViewController {
    
    let NUM_PAGE = 10

    @IBOutlet var lblNumber: UILabel!
    @IBOutlet var myPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myPageControl.numberOfPages = NUM_PAGE // myPageControl.numberOfPages = 10 도 가능하지만, 상수로 명시하는 것이 바람직함
        myPageControl.currentPage = 0
        
        myPageControl.currentPageIndicatorTintColor = UIColor.black
        myPageControl.pageIndicatorTintColor = UIColor.lightGray
        
        lblNumber.text =  String(myPageControl.currentPage + 1) // 초기값을 1로 지정
        // lblNumber.text =  "\(myPageControl.currentPage + 1)" // 동일함
    }

    // Page Control을 터치하면 currenPage 값을 반영하여 Label 수정
    @IBAction func changeLabel(_ sender: UIPageControl) {
        
        lblNumber.text = String(myPageControl.currentPage + 1)
        // lblNumber.text = "\(myPageControl.currentPage + 1)" // 동일함
    }
}

