# DoItSwift
&lt;Do It Swift> example source code. (Xcode, Swift, StoryBoard) 
* [iOS Device] : iPhone12 


# 프로젝트 소개
## 1_HelloWorld
* UITextField에 사용자가 값을 입력하고 UIButton을 누르면, UILabel에 "Hello, 입력값"을 출력함

## 2_ImageView
* UIImageView를 활용하여 UIButton을 누르면 image를 확대/축소하고, UISwitch를 누르면 image를 변경함

## 3_RoseViewController
* UIImageView를 활용하여 UIButton (Prev 또는 Next 버튼)을 누르면 image (총 6개)를 변경하는 기능 
* 사용자 편의를 위해 1번 image에서 이전을 누르면 6번으로 이동, 6번 image에서 Next 버튼을 누르면 1번으로 이동하는 기능을 추가

## 4_DatePicker
* Timer Class (#selector Struct, NSDate Class)를 통해 1초 단위로 정보를 업데이트하며, UILabel에 현재 시간을 나타냄
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

### 7.2_Web App
* 앱이 시작될 때 WebView를 통해 HTML 파일을 읽어 디스플레이하고, Link를 통해 workflowy 웹사이트로 이동함

## 8_Map View
* Map View (MKMapView-CLLocationManagerDelegate protocol 상속, CLLocationManager Class 사용 등) 및 UISegmentedControl (총 3개)을 통해 사용자가 Segment를 터치하면 각각 사용자의 현재 위치, 지정 장소1, 지정 장소2를 Map에 나타냄
* 사용자의 현재 위치가 업데이트 되면 Map을 이동함. 이때 현재 위치의 위도/경도를 활용하여 주소 (국가/지역/도로명)를 구하고, 하단에 텍스트로 나타냄
* 지정 장소1, 지정 장소2에 핀을 설치하고, 하단에 위치 설명 텍스트를 나타냄. 핀을 터치하면 장소명 (title) 및 주소 (subtitle)를 보여주는 기능을 추가
* 위도/경도 외에도 범위 (delta span) 수치를 활용하여 Map의 배율을 조정 가능함

### 8.2_Map My Home
* 8_MapView를 응용함. Segment를 추가하여 My Home에 핀을 설치함

## 9_Page Control
* UIPageControl을 활용하여 6개 이미지를 개별 페이지에 나타내고, 하단의 Page Control의 좌측/우측을 터치하면 각각 이전 이미지/다음 페이지로 이동함 
* Page Indicator (현재 페이지 및 미선택 페이지)의 색상을 변경하는 기능을 추가

### 9.2_Page Control을 통한 Label 수정
* 9_Page Control을 응용함. UIPageControl 및 UILabel을 활용하여 화면에 페이지 번호 (1~10)를 표시함 

## 10_Tab Bar Controller
* Tab Bar Controller를 활용하여 하나의 앱에서 여러 화면 (View Controller)을 나타냄
* 하단의 3개 탭을 터치하면 각각 다른 화면을 보여주며, 두번째 및 세번째 탭은 기존에 만든 project (2_ImageView 및 4_DatePicker)를 활용함. 기존 project의 storyboard의 View Controller 및 swift 파일 (소스코드)를 그대로 사용함
* 초기화면 (첫번째 탭) 상단의 UIButton을 통해 두번째 및 세번째 화면으로 이동하는 기능을 추가

### 10.2_New Tab
* 10_Tab Bar Controller을 응용함. 기존 project (5_PickerView)를 사용하여 Tab Bar Controller의 탭을 1개 추가 

## 11_Navigation Controller
* Navigation Controller 및 Segue (prepare 메서드, Delegate protocol)를 활용하여 화면을 전환하면서 데이터를 전달함
* 초기화면 상단의 UIBar Button (Edit Button) 또는 UIButton (수정 Button)을 터치하면, Main화면에서 Edit화면으로 이동하고 Label에 Segue 정보 ("use Bar Button" 또는 "use Button")를 나타냄. 또한 Main화면에서 Message 하단의 TextField에 입력한 텍스트를 Edit화면에서 그대로 보여줌
* Edit화면에서 UIButton (완료 Button)을 통해 Main화면으로 재이동함. 마찬가지로 이때 Message 하단의 TextField에 텍스트를 수정하면, Main화면에서 그대로 보여줌. 또한 UISwitch를 터치하여 값을 변경한 경우, Main화면의 Lamp 이미지에 반영함

### 11.2_LampSize
* 11_Navigation Controller를 응용함. Edit화면에 UIButton을 추가하여 Main화면의 이미지가 축소된 상태면, 버튼 이름을 '축소'로 표시함 (확대인 상태도 동일)
* Edit화면의 축소 버튼을 터치하면, 버튼 이름을 '확대'로 변경하고 Main화면의 이미지를 확대함. 이때, 이미지가 이미 확대된 상태이면 이미지 크기를 유지함 (축소인 상태도 동일)

## 12_Table View Controller
* UITableViewController 및 Navigation Controller를 활용하여 목록 기능을 구현
* 초기화면 Main View에서는 목록을 확인 가능함. 각 항목을 왼쪽으로 swipe 하면 '삭제' 버튼이 나타나며 삭제 가능함. 또한 좌측 상단의 'Edit' 버튼을 터치하면, 각 항목을 삭제 (항목 좌측 버튼을 터치) 하거나 행 이동 (항목 우측 버튼을 swipe) 이 가능함
* 우측 상단의 '+' 버튼을 터치하면, Add View 화면으로 이동함. 새로운 항목을 작성하고 'Add' 버튼을 터치하면, Main View로 다시 이동하며 추가된 항목이 업데이트됨 (Segue 및 외부 변수 사용)
* 목록의 각 항목을 터치하면, Detail View 화면으로 이동하며 해당 항목의 정보가 나타남 (Segue 및 prepare 함수 사용)

### 12.2_Icon Selection
* 12_Table View Controller를 응용함. Add View에서 새로운 항목을 추가할 때, Picker View를 통해 사용자가 아이콘을 선택하는 기능을 추가함
