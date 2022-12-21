//
//  ViewController.swift
//  HelloWorld
//
//  Created by Sudon Noh on 2022/12/19.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var uiTitle: UILabel!
    
    @IBOutlet var uiContent: UILabel!
    
    @IBOutlet var uiContent2: UILabel!
    
    // 앱이 실행될 때 최초 자동으로 호출
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sayHello(_ sender: Any) {
        self.uiTitle.text = "Hello, World!"
    }
}

