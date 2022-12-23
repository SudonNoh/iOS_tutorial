//
//  ViewController.swift
//  Msg-AlertController
//
//  Created by Sudon Noh on 2022/12/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    /*
    // 화면이 뜨자마자 자동으로 메시지 창을 띄워주어야 할 경우에는 viewDidAppear를 사용
    // 예를들어 네트워크 관련 알림창 같은 경우
    // viewDidLoad를 쓸 경우 런타임 오류 발생, 이유는 메시지 창을 처리해줄 뷰가
    // 화면에 구성되지 않은 상태에서 먼저 화면 전환을 시도했기 때문
    override func viewDidAppear(_ animated: Bool) {
        let alert = UIAlertController(title: <#T##String?#>, message: <#T##String?#>, preferredStyle: <#T##UIAlertController.Style#>)
    }
    */

    @IBOutlet var result: UILabel!
    
    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(
            title: "선택",
            message: "항목을 선택해주세요.",
            preferredStyle: .alert
        )
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) {
            (_) in self.result.text = "취소 버튼을 클릭했습니다."
        }
        let ok = UIAlertAction(title: "확인", style: .default) {
            (_) in self.result.text = "확인 버튼을 클릭했습니다."
        }
        let exec = UIAlertAction(title: "실행", style: .destructive) {
            (_) in self.result.text = "실행 버튼을 클릭했습니다."
        }
        let stop = UIAlertAction(title: "중지", style: .default) {
            (_) in self.result.text = "중지 버튼을 클릭했습니다."
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addAction(exec)
        alert.addAction(stop)
        
        self.present(alert, animated: false)
    }
    
    
    @IBAction func login(_ sender: Any) {
        let title = "iTunes Store에 로그인"
        let message = "사용자의 Apple ID sqlpro@naver.com의 암호를 입력하십시오"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { (_) in
            if let tf = alert.textFields?[0] {
                print("입력된 값은 \(tf.text!)입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        // 텍스트 필드 추가
        alert.addTextField(configurationHandler: {(tf) in
            // 텍스트필드의 속성 설정
            tf.placeholder = "암호" // 안내 메시지
            tf.isSecureTextEntry = true // 비밀번호 처리
        })
        
        self.present(alert, animated: false)
        
    }
    
    @IBAction func auth(_ sender: Any) {
        let msg = "로그인"
        
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title:"취소", style: .cancel)
        let ok = UIAlertAction(title:"확인", style: .default) { (_) in
            let loginId = alert.textFields?[0].text
            let loginPw = alert.textFields?[1].text

            if loginId == "AXCE" && loginPw == "1234" {
                self.result.text = "인증에 성공했습니다."
            } else {
                self.result.text = "인증에 실패했습니다."
            }
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "아이디"
            tf.isSecureTextEntry = false
        })
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "비밀번호"
            tf.isSecureTextEntry = true
        })
        
        self.present(alert, animated: false)
    }
}

