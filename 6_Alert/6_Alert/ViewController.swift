//
//  ViewController.swift
//  6_Alert
//
//  Created by Hyoju Son on 2021/06/04.
//

import UIKit

class ViewController: UIViewController {

    let imgOn = UIImage(named: "lamp-on.png") // 해당 파일명의 image는 지정 이후 불변하므로 let 선언
    let imgOff = UIImage(named: "lamp-off.png")
    let imgRemove = UIImage(named: "lamp-remove.png")
    
    var isLampOn: Bool = true // 전구 ON/OFF 여부 (ON이면 true)
    
    @IBOutlet var lampImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lampImg.image = imgOn // 초기 이미지 지정
    }

    // 1) 이미 ON상태라면 Alert-경고메시지, 2) OFF상태이면 전구를 켬
    @IBAction func btnLampOn(_ sender: UIButton) {
        if (isLampOn == true) { // 1) Alert - UIAlertController를 매개변수로 가진 present 메서드 실행
            let lampOnAlert = UIAlertController(title: "WARNING",
                                                message: "현재 ON 상태입니다. 전기를 아껴쓰세요.",
                                                preferredStyle: .alert) // UIAlertController.Style.alert -> .alert 가능
            let onAction = UIAlertAction(title: "OK", style: .default,
                                         handler: nil) // UIAlertAction.Style.default -> .default 가능. 특별한 동작이 없을 경우 handler-nil
            
            lampOnAlert.addAction(onAction) // UIAlertController에 UIAlertAction을 추가함
            present(lampOnAlert, animated: true, completion: nil) // Presents a view controller modally.
            
        } else { // 2)
            lampImg.image = imgOn
            isLampOn = true
        }
    }
    
    // 1) ON상태이면 Alert-전구를 끌 것인지 선택하고, 2) 이미 OFF상태라면 무동작
    @IBAction func btnLampOff(_ sender: UIButton) {
        
        if (isLampOn == true) { // 1). if (isLampOn) {} 과 동일
            let lampOffAlert = UIAlertController(title: "Lamp 끄기", message: "Lamp를 끄시겠습니까?", preferredStyle: .alert)
            
         // alert 창에서 전구를 끌지 말지 (off,cancel) 선택해야 하므로 Action 2개를 생성함
            let offAction = UIAlertAction(title: "네", style: .default,
                                          handler: {
                                            ACTION in self.lampImg.image = self.imgOff
                                            self.isLampOn = false
            }) // handler-"네" 선택 시 실행할 동작을 {}에 코딩함 *self???
            let cancelAction = UIAlertAction(title: "아니오", style: .default, handler: nil)
            
            lampOffAlert.addAction(offAction) // Action을 각각 추가함
            lampOffAlert.addAction(cancelAction)
            
            present(lampOffAlert, animated: true, completion: nil)
            
            // 참고-Alert 없이 바로 OFF하는 경우
//            lampImg.image = imgOff
//            isLampOn = false
        } // 2) else문 필요없음. 실행할 동작이 없으므로
    }
    
    // ON/OFF 상태에 상관없이 Alert-ON/OFF/Remove 중 하나를 선택. Remove할 경우 붉은 글씨로 표시
    @IBAction func btnLampRemove(_ sender: UIButton) {
        let lampRemoveAlert = UIAlertController(title: "Lamp 제거", message: "Lamp를 제거하시겠습니까?", preferredStyle: .alert)
        
        let onAction = UIAlertAction(title: "아니오, 켭니다.", style: .default, handler: {
                                                                                ACTION in self.lampImg.image = self.imgOn
                                                                                self.isLampOn = true
        })
        let OffAction = UIAlertAction(title: "아니오, 끕니다.", style: .default) { // syntax - handler: {}) -> <후행 클로져 외부구현>과 마찬가지로 handler 매개변수를 삭제하고 ){} 로 표현 가능
                                                                            ACTION in self.lampImg.image = self.imgOff
                                                                            self.isLampOn = false
        }
        let removeAction = UIAlertAction(title: "네, 제거합니다.", style: .destructive, handler: { // style: .default가 아니라 .destructive (*빨간색 글씨로 표시됨. Apply a style that indicates the action might change or delete data.)
                                                                                        ACTION in self.lampImg.image = self.imgRemove
                                                                                        self.isLampOn = false // 왜?
        })
     
        lampRemoveAlert.addAction(onAction)
        lampRemoveAlert.addAction(OffAction)
        lampRemoveAlert.addAction(removeAction)
        
        present(lampRemoveAlert, animated: true, completion: nil)
    }
}

