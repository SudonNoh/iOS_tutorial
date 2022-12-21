//
//  ViewController.swift
//  IBTest
//
//  Created by Sudon Noh on 2022/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTitle01: UILabel!
    @IBOutlet var uiTitle02: UILabel!
    @IBOutlet var uiTitle03: UILabel!
    @IBOutlet var uiTitle04: UILabel!
    @IBOutlet var uiTitle05: UILabel!
    
    @IBAction func clickBtn01(_ sender: Any) {
        self.uiTitle01.text = "Button01 Clicked"
    }
    
    @IBAction func clickBtn02(_ sender: Any) {
        self.uiTitle02.text = "Button02 Clicked"
    }
    
    @IBAction func clickBtn03(_ sender: Any){
        self.uiTitle03.text = "Button03 Clicked"
    }
    
    @IBAction func clickBtn04(_ sender: Any){
        self.uiTitle04.text = "Button04 Clicked"
    }
    
    @IBAction func clickBtn05(_ sender: Any) {
        self.uiTitle05.text = "Button05 Clicked"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

