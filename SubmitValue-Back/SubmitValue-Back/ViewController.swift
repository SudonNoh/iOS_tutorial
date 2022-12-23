//
//  ViewController.swift
//  SubmitValue-Back
//
//  Created by Sudon Noh on 2022/12/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var resultEmail: UILabel!
    @IBOutlet var resultUpdate: UILabel!
    @IBOutlet var resultInterval: UILabel!
    
    /*
    var paramEmail: String?
    var paramUpdate: Bool?
    var paramInterval: Double?
    */
    
    override func viewWillAppear(_ animated: Bool) {
        /* 값을 직접 전달하는 동기적 방식
        if let email = paramEmail {
            resultEmail.text = email
        }
        
        if let update = paramUpdate {
            resultUpdate.text = update == true ? "자동갱신":"자동갱신안함"
        }
        
        if let interval = paramInterval {
            resultInterval.text = "\(Int(interval))분마다"
        }
        */
        
        /* 값을 AppDelegate에 저장 후 전달하는 비동기적 방식
        // AppDelegate 객체의 인스턴스를 가져온다.
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let email = ad?.paramEmail {
            resultEmail.text = email
        }
        if let update = ad?.paramUpdate {
            resultUpdate.text = update == true ? "자동갱신":"자동갱신안함"
        }
        if let interval = ad?.paramInterval {
            resultInterval.text = "\(Int(interval))분마다"
        }
        */
        
        /* 값을 UserDefaults에 저장 후 전달하는 비동거직 방식 */
        let ud = UserDefaults.standard
        
        if let email = ud.string(forKey: "email") {
            resultEmail.text = email
        }
        
        let update = ud.bool(forKey: "isUpdate")
        resultUpdate.text = (update == true ? "자동갱신":"자동갱신안함")
        
        let interval = ud.double(forKey: "interval")
        resultInterval.text = "\(interval)분마다"
    }
}

