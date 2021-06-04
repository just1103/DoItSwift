# DoItSwift
&lt;Do It Swift> example source code. (Xcode, Swift, StoryBoard)

## 프로젝트 소개
1_HelloWorld
* UITextField에 사용자가 값을 입력하고 UIButton을 누르면, UILabel에 "Hello, 입력값"을 출력함

2_ImageView
* UIImageView를 활용하여 UIButton을 누르면 UIImage를 확대/축소하고, UISwitch를 누르면 UIImage를 변경함

3_RoseViewController
* UIImageView를 활용하여 UIButton-Prev 또는 UIButton-Next을 누르면 image를 변경하는 기능 (6개 image를 사용했으며, 사용자 편의를 위해 1번 image에서 이전을 누르면 6번으로 이동, 6번 image에서 Next 버튼을 누르면 1번으로 이동하는 기능을 추가함)

4_DatePicker
* Timer Class (#selector Struct, NSDate Class)를 통해 1초 단위로 정보를 업데이트하며,  UILabel에 현재 시간을 나타냄
* UIDatePicker (DateFormatter Class)를 활용하여 사용자의  선택 시간을 UILabel에 나타냄

4.2_Alarm
* 4_DatePicker를 응용함. 현재 시간과 선택 시간이 일치하는 1분 동안 UIColor를 활용하여 배경화면을 빨간색으로 변경함

5_PickerView
* UIPickerView를 활용 (UIPickerViewDelegate Class 상속, Delegate method 사용)하여 사용자가 룰렛에서 선택한 값을 UILabel 및 UIImageView를 통해 파일명 및 image로 나타냄
* PickerView의 룰렛에 파일명 (옵션1) 또는 image (옵션2)를 나타냄

5.2_MultiCompPickerView
* 5_PickerView를 응용하여 PickerView의 Component (Column)을 2개로 지정함
* 왼쪽 Column의 값을 선택하면 UIIabel의 파일명을 변경, 오른쪽 Column의 값을 선택하면 UIImage의 image를 변경함

