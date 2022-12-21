//
//  SecondViewController.swift
//  Scene-Trans02
//
//  Created by Sudon Noh on 2022/12/21.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBAction func movePrevious(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    @IBAction func movePrevious2(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
