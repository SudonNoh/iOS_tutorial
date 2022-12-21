//
//  NewSegue.swift
//  Scene-CustomSegue
//
//  Created by Sudon Noh on 2022/12/21.
//

import UIKit

class NewSegue: UIStoryboardSegue {
    override func perform() {
        // 세그웨이의 출발지 뷰 컨트롤러
        let srcUVC = self.source
        
        // 세그웨이의 목적지 뷰 컨트롤러
        let destUVC = self.destination
        
        UIView.transition(from: srcUVC.view, to: destUVC.view, duration: 2, options: .transitionCurlDown)
    }
}
