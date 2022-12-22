//
//  FormViewController.swift
//  SubmitValue-Back
//
//  Created by Sudon Noh on 2022/12/22.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var isUpdate: UISwitch!
    @IBOutlet var interval: UIStepper!
    @IBOutlet var stateOfUpdate: UILabel!
    @IBOutlet var stateOfInterval: UILabel!
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        if (sender.isOn == true) {
            self.stateOfUpdate.text = "갱신함"
        } else {
            self.stateOfUpdate.text = "갱신하지 않음"
        }
    }
    
    @IBAction func onStepper(_ sender: UIStepper) {
        let value = Int(sender.value)
        self.stateOfInterval.text = "\(value)분 마다"
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let preVC = self.presentingViewController
        // self.presentingViewController 를 통해 이전 ViewController를
        // 불러오는데, 이때 타입은 UIViewController 이다. 타입이 UIViewController인
        // 상태에서는 ViewController의 모든 프로퍼티를 참조할 수 없기 떄문에
        // ViewController로 타입캐스팅 해주어야 한다.
        guard let vc = preVC as? ViewController else {
            return
        }
        
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        
        self.presentingViewController?.dismiss(animated: true)
    }
}
