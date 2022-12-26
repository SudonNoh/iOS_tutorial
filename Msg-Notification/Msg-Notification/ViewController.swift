//
//  ViewController.swift
//  Msg-Notification
//
//  Created by Sudon Noh on 2022/12/23.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet var msg: UITextField!
    @IBOutlet var datepicker: UIDatePicker!
    
    @IBAction func save(_ sender: Any) {
        // 버전별로 로컬 알림을 구현 처리
        if #available(iOS 10, *) {
            // UserNotification 프레임워크를 사용한 로컬 알림
            // 알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    // 알림 설정이 들어갈 곳
                    DispatchQueue.main.async {
                        // 알림 콘텐츠 정의
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리 알림"
                        nContent.sound = UNNotificationSound.default
                        
                        // 발송 시각을 '지금으로 부터 *초 형식'으로 변환
                        let time = self.datepicker.date.timeIntervalSinceNow
                        // 발송 조건 정의
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        // 발송 요청 객체 정의
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                        // 노티피케이션 센터에 로컬 알림을 등록하는 add(_:) 메소드는 두 번째 인자값으로 완료 시 호출 될 클로저를
                        // 입력할 수 있다. 이를 이용해 메소드 뒤에 트레일링 클로저 형식으로 메시지 창을 호출하면 된다.
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                // 세계 표준시를 기준으로 보여주는데, 이를 우리나라 기준으로 변경하기 위해 9시간을 추가해야 한다.
                                // addingTimeInterval 의 입력값의 단위가 초이기 때문에 9시간을 초 단위로 변경해서 입력한다.
                                let date = self.datepicker.date.addingTimeInterval(9*60*60)
                                let message = "알람이 등록되었습니다. 등록된 알람은 \(date)에 발송됩니다."
                                
                                let alert = UIAlertController(title: "알람등록", message: message, preferredStyle: .alert)
                                
                                let ok = UIAlertAction(title: "확인", style: .default)
                                
                                alert.addAction(ok)
                                
                                self.present(alert, animated: false)
                            }
                        }
                    }
                } else {
                    let alert = UIAlertController(title: "알림등록", message: "알림이 허용되지 않았습니다.", preferredStyle: .alert)
                    let ok = UIAlertAction(title:"확인", style: .default)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    return
                }
            }
        } else {
            // LocalNotification 객체를 사용한 로컬 알림
        }
    }
}

