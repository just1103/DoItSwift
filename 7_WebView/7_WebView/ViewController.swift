//
//  ViewController.swift
//  7_WebView
//
//  Created by Hyoju Son on 2021/06/07.
//

import UIKit
import WebKit // WKWebView가 정의되어 있음

class ViewController: UIViewController, WKNavigationDelegate { // Activity Indicator 사용을 위해 WKNavigationDelegate protocol 상속 - Methods for accepting or rejecting navigation changes, and "for tracking the progress of navigation requests."

    @IBOutlet var txtUrl: UITextField!
    @IBOutlet var myWebView: WKWebView!
    @IBOutlet var myActivityIndicator: UIActivityIndicatorView! // 보이기/감추기 속성을 제어해야 하므로 Outlet 변수 선언
    
    // 웹 뷰에 웹 페이지를 보여주기 위한 함수 - viewDidLoad에 들어갈 부분 (즉, viewDidLoad에서 함수를 호출하여 지정된 URL의 웹페이지를 보여줌)
      // 보통 함수 선언은 @IBAction 아래에 했는데 왜지??? - viewDidLoad에 바로 위에 두면 찾기 쉬워서?
    func loadWebPage(_ url: String){  // String형 URL을 이용하여 웹페이지를 나타내기 (1)~(4)
        let myUrl = URL(string: url)  // (1) String형 URL 값을 받아 "URL형"으로 convert하여 상수에 저장
        let myRequest = URLRequest(url: myUrl!)  // (2) 상수를 받아 "URL Request형"으로 convert하여 상수에 저장
        myWebView.load(myRequest)  // (3) UIWebView형 (웹킷뷰 type)의 myWebView (Outlet 변수)의 load 메서드를 호출함 (Loads the web content referenced by the specified URL rlequest object and navigates to it.) URL Request를 받아 웹페이지로 load
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        myWebView.navigationDelegate = self // Activity Indicator 사용을 위해 Navigation Delegate object 사용 (manage or restrict navigation in your web content, "track the progress of navigation requests", and handle authentication challenges for any new content 등의 목적으로 사용함) - 웹 뷰가 로딩중인 지 살펴보는 delegate 기능???
        
        loadWebPage("http://2sam.net")  // (4) 앱 초기화면에서 접속할 웹페이지 주소를 추가하여 loadWebPage 함수를 실행. 단, Info.plist (info property list, key-value pair로 들어있는 언어, 실행파일명, 앱 식별자 등 리소스 설정을 확인) 파일 수정이 필요함. Navigator의 Info.plist>(+)하여 App Transport Security Settings 추가>(+)하여 하단에 Allow Arbitrary Loads 추가>우측 value 값을 NO에서 YES로 변경. 다시 실행하면 지정한 웹페이지가 나타남
        
    }
    
    // Activity Indicator를 실행하여 화면에 보이게/숨기게 할 webView 메서드들을 사용함
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) { // webView 메서드 - Tells the delegate that the web view has started to receive content for the main frame. - delegate에게 loading 중인 지 (콘텐츠를 받기 시작했는 지) 알려주는 기능
        myActivityIndicator.startAnimating() // startAnimating 메서드 - Starts the animation of the progress indicator.
        myActivityIndicator.isHidden = false // isHidden 메서드 - Setting the value of this property to true hides the receiver and setting it to false shows the receiver. The default value is false. - load 중이면 indicator가 보이게 함
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = true // load 완료하면 indicator를 숨김
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = true // load 실패하면 indicator를 숨김
    }
    
    // 프로토콜이 없으면 "http://" String을 자동 추가하는 함수 - 사용자가 protocol (http://)을 직접 입력하지 않아도 자동으로 웹브라우저로 이동 가능함
      // 왜 여기에 정의? -> btnGotoUrl에 들어갈 내용이므로 바로 위에 두면 찾기 편해서?
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
        // txtUrl.text = "" // 왜 없애주지? -> 필수 아님. 없어도 정상 동작함
        loadWebPage(myUrl)
    }
    
    // 이건 왜 Bar Item으로 안 만들지?
    @IBAction func btnGoSite1(_ sender: UIButton) {
        loadWebPage("http://fallinmac.tistory.com")
    }
    @IBAction func btnGoSite2(_ sender: UIButton) {
        loadWebPage("http://www.getbarrel.com/") // BARREL 사이트를 넣어봤는데, 자동으로 모바일 사이트로 이동됨 (반응형 웹인가??)
    }
    
    //
    @IBAction func btnLoadHtmlString(_ sender: UIButton) { // html 코드를 변수에 저장하여 웹 뷰로 구현
        let htmlString = "<h1> HTML String </h1><P> String 변수를 이용한 웹페이지 </p><p><a href=\"http://2sam.net\">2sam 사이트</a>로 이동</p>" // 왜 \"http://2sam.net\" 에서 백슬래쉬를 쓰지? -> "" 내부에 또 ""를 넣어야 하므로
        myWebView.loadHTMLString(htmlString, baseURL: nil) // loadHTMLString 메서드 - Loads the contents of the specified HTML string and navigates to it.
    }
    @IBAction func btnLoadHtmlFile(_ sender: UIButton) { // html 파일을 웹 뷰로 구현 (모바일용 html 파일이면 iOS전용 앱으로 가능)
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html") // (A) htmlView.html 파일에 대한 path 변수를 생성. main bundle은 앱이 실행되는 코드가 있는 Bundle 디렉토리에 접근 가능하도록 함
        let myUrl = URL(fileURLWithPath: filePath!) // (B) path를 받아 URL 변수를 생성 - ***같은 class 내부의 method인 loadWebPage 함수에서 선언한 myUrl 상수와 왜 충돌하지 않지??? ㅠㅠ
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
