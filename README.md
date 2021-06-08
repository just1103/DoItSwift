# DoItSwift
&lt;Do It Swift> example source code. (Xcode, Swift, StoryBoard)

# 프로젝트 소개
## 1_HelloWorld
* UITextField에 사용자가 값을 입력하고 UIButton을 누르면, UILabel에 "Hello, 입력값"을 출력함

## 2_ImageView
* UIImageView를 활용하여 UIButton을 누르면 image를 확대/축소하고, UISwitch를 누르면 image를 변경함

## 3_RoseViewController
* UIImageView를 활용하여 UIButton (Prev 또는 Next 버튼)을 누르면 image (총 6개)를 변경하는 기능 
* 사용자 편의를 위해 1번 image에서 이전을 누르면 6번으로 이동, 6번 image에서 Next 버튼을 누르면 1번으로 이동하는 기능을 추가

## 4_DatePicker
* Timer Class (#selector Struct, NSDate Class)를 통해 1초 단위로 정보를 업데이트하며,  UILabel에 현재 시간을 나타냄
* UIDatePicker (DateFormatter Class)를 활용하여 사용자의 선택 시간을 UILabel에 나타냄

### 4.2_Alarm
* 4_DatePicker를 응용함. 현재 시간과 선택 시간이 일치하는 1분 동안 UIColor를 활용하여 배경화면을 빨간색으로 변경함

## 5_PickerView
* UIPickerView를 활용 (UIPickerViewDelegate Class 상속, Delegate 메서드 사용)하여 사용자가 룰렛에서 선택한 값을 UILabel 및 UIImageView를 통해 파일명 및 image로 나타냄
* PickerView의 룰렛에 파일명 (옵션1) 또는 image (옵션2)를 나타냄

### 5.2_MultiCompPickerView
* 5_PickerView를 응용하여 PickerView의 Component (Column)를 2개로 지정함
* 왼쪽 Column의 값을 선택하면 UIIabel의 파일명을 변경, 오른쪽 Column의 값을 선택하면 UIImage의 image를 변경함

## 6_Alert
* UIAlertController/UIAlertAction 및 present 메서드를 사용하여 3개 UIButton (켜기/끄기/제거 버튼)을 통해 image를 변경하고, 알림 메시지를 나타냄
* 제거 버튼의 경우, Alert에 대한 사용자의 선택에 따라 특정 동작을 실행함

### 6.2_Time Alert
* 4.2_Alarm 및 6_Alert를 응용함. 현재 시간 (Timer로 업데이트)과 선택 시간 (Date Picker에서 사용자가 선택)이 일치하면, UIAlertController/UIAlertAction을 활용하여 알림 메시지를 나타냄
* 사용자가 Alert를 확인한 이후에는 1분 동안 다시 알림 메시지가 나타나지 않도록 설정함

## 7_Web View
* WebView (WKWebView) 및 UIButton (Go button)을 통해 사용자가 UITextField에 입력한 URL 주소의 웹페이지로 이동함
* UIAcitivityIndicator (WKNavigationDelegate protocol 상속, navigationDelegate object 사용 등)를 통해 사용자에게 웹페이지가 로딩 중임을 알려줌
* 4개 UIButton (Site1, Site2, HTML, File)을 통해 지정된 주소로 이동하고, html string 코드 및 html file의 내용을 웹페이지에 나타냄
* 하단 Tool bar의 4개 아이콘 (정지, 새로고침, 이전 페이지, 다음 페이지)를 통해 페이지 로딩을 중지하고, 현재 페이지를 새로고침하고, 이전/다음 페이지로 이동하는 기능
