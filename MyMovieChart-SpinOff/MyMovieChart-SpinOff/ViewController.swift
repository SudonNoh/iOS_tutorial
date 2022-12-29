//
//  ViewController.swift
//  MyMovieChart-SpinOff
//
//  Created by Sudon Noh on 2022/12/30.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

/*
 아래 두 개의 프로토콜들은 테이블 뷰 컨트롤러를 직접 상속받아 사용할 떄는 추가하지 않아도 된다.
 UITableViewController 클래스 내부에 이미 추가되어 있다.
*/

// 테이블을 구성하기 위해 필요한 메소드 정의
// tableView(_:numberOfRowsInSection:)
// tableView(_:cellForRowAt:)
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(indexPath.row)번째 데이터입니다."
        return cell
    }
    
}

// 테이블에서 발생하는 액션/이벤트와 관련된 메소드 정의
// tableView(_:didSelectRowAt:)
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("\(indexPath.row)번째 데이터가 클릭됨")
    }
}
