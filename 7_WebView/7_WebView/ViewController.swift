//
//  ViewController.swift
//  7_WebView
//
//  Created by Hyoju Son on 2021/06/07.
//
// README.md
// * WebView (WKWebView) 및 UIButton (Go button)을 통해 사용자가 UITextField에 입력한 URL 주소의 웹페이지로 이동함
// * UIAcitivityIndicator (WKNavigationDelegate protocol 상속, navigationDelegate object 사용 등)를 통해 사용자에게 웹페이지가. 로딩 중임을 알려줌
// * 4개 UIButton (Site1, Site2, HTML, File)을 통해 지정된 주소로 이동하고, html string 코드 및 html file의 내용을 웹페이지에 나타냄
// * 하단 Tool bar의 4개 아이콘 (정지, 새로고침, 이전 페이지, 다음 페이지)를 통해 페이지 로딩을 중지하고, 현재 페이지를 새로고침하고, 이전/다음 페이지로 이동하는 기능


import UIKit
import WebKit // WKWebView가 정의되어 있음

class ViewController: UIViewController, WKNavigationDelegate { // Activity Indicator 사용을 위해 WKNavigationDelegate protocol 상속
    
    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView! // 보이기/감추기 속성을 제어해야 하므로 Outlet 변수 선언
    
    // 웹 뷰에 웹 페이지를 보여주기 위한 함수 - viewDidLoad에 들어갈 부분 (즉, viewDidLoad에서 함수를 호출하여 지정된 URL의 웹페이지를 보여줌)
    func loadWebPage(_ url: String){  // String형 URL을 이용하여 웹페이지를 나타내기 (1)~(4)
        let myUrl = URL(string: url)  // (1) String형 URL 값을 받아 "URL형"으로 convert하여 상수에 저장
        let myRequest = URLRequest(url: myUrl!)  // (2) 상수를 받아 "URL Request형"으로 convert하여 상수에 저장
        myWebView.load(myRequest)  // (3) UIWebView형 (웹킷뷰 type)의 myWebView (Outlet 변수)의 load 메서드를 호출함. URL Request를 받아 웹페이지로 load
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myWebView.navigationDelegate = self // Activity Indicator 사용을 위해 Navigation Delegate object 사용
        
        loadWebPage("http://2sam.net")  // (4) 앱 초기화면에서 접속할 웹페이지 주소를 추가하여 loadWebPage 함수를 실행. 단, Info.plist (info property list, key-value pair로 들어있는 언어, 실행파일명, 앱 식별자 등 리소스 설정을 확인) 파일 수정이 필요함. Navigator의 Info.plist>(+)하여 App Transport Security Settings 추가>(+)하여 하단에 Allow Arbitrary Loads 추가>우측 value 값을 NO에서 YES로 변경. 다시 실행하면 지정한 웹페이지가 나타남
    }
    
    // Activity Indicator를 실행하여 화면에 보이게/숨기게 할 webView 메서드들을 사용함
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { // webView 메서드 - delegate에게 loading 중인 지 (콘텐츠를 받기 시작했는 지) 알려주는 기능
        myActivityIndicator.startAnimating() // startAnimating 메서드
        myActivityIndicator.isHidden = false // isHidden 메서드 - load 중이면 indicator가 보이게 함
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = true // load 완료하면 indicator를 숨김
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = true // load 실패하면 indicator를 숨김
    }
    
    // 프로토콜이 없으면 "http://" String을 자동 추가하는 함수
    func checkUrl(_ url: String) -> String { // URL 주소를 String으로 받고, 처리한 후 다시 문자열로 가져옴
        var strUrl = url // 사용자가 입력한 URL를 받아 변수에 저장
        let flag = strUrl.hasPrefix("http://") // 접두사에 http://가 없으면 flag에 false가 return됨
        if !flag { // flag == false 와 동일함
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGotoUrl(_ sender: UIButton) { // 사용자가 textfield에 입력한 URL로 checkUrl 함수를 호출하여 웹 뷰를 load
        let myUrl = checkUrl(txtUrl.text!)
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://www.getbarrel.com/")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: UIButton) { // html 코드를 변수에 저장하여 웹 뷰로 구현
        let htmlString = "<h1> HTML String </h1><P> String 변수를 이용한 웹페이지 </p><p><a href=\"http://2sam.net\">2sam 사이트</a>로 이동</p>" // 왜 \"http://2sam.net\" 에서 백슬래쉬를 쓰지? -> "" 내부에 ""를 넣어야 하므로
        myWebView.loadHTMLString(htmlString, baseURL: nil) // loadHTMLString 메서드
    }
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) { // html 파일을 웹 뷰로 구현 (모바일용 html 파일이면 iOS전용 앱으로 가능)
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html") // (A) htmlView.html 파일에 대한 path 변수를 생성. main bundle은 앱이 실행되는 코드가 있는 Bundle 디렉토리에 접근 가능하도록 함
        let myUrl = URL(fileURLWithPath: filePath!) // (B) path를 받아 URL 변수를 생성
        let myRequest = URLRequest(url: myUrl) // (C) URL을 받아 URL Request 변수를 생성
        myWebView.load(myRequest) // (D) URL Request를 받아 html 파일을 load
    }
    
    // 정지, 새로고침, 이전페이지, 다음페이지 버튼
    @IBAction func btnStop(_ sender: UIBarButtonItem) {
        myWebView.stopLoading()
    }
    @IBAction func btnReload(_ sender: UIBarButtonItem) {
        myWebView.reload()
    }
    @IBAction func btnGoBack(_ sender: UIBarButtonItem) {
        myWebView.goBack()
    }
    @IBAction func btnGoForward(_ sender: UIBarButtonItem) {
        myWebView.goForward()
    }
}
