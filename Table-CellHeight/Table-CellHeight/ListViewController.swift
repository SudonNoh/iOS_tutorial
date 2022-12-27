//
//  ListViewController.swift
//  Table-CellHeight
//
//  Created by Sudon Noh on 2022/12/27.
//

import UIKit

class ListViewController: UITableViewController {
    // 테이블 뷰에 연결될 데이터를 저장하는 배열
    var list = [String]()
    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "목록 입력", message: "추가될 글을 작성해주세요.", preferredStyle: .alert)
        
        alert.addTextField() { (tf) in
            tf.placeholder = "내용을 입력하세요."
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            if let title = alert.textFields?[0].text {
                self.list.append(title)
                self.tableView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // "cell" 아이디를 가진 셀을 읽어온다. 없으면 UITableViewCell 인스턴스를 생성한다.
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        // 셀의 기본 텍스트 레이블 행 수 제한을 없앤다.
        // 기본 값은 1로 글자가 아무리 길어도 한 줄로만 표현된다.
        cell.textLabel?.numberOfLines = 0
        // 셀의 기본 텍스트 레이블에 배열 변수의 값을 할당한다.
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
    /* 정적인 방법으로 셀의 높이를 조절할 때 사용
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = self.list[indexPath.row]
        // 기본 높이 60에 해당 행에 들어갈 데이터의 길이가 30이 넘을 때마다 20씩 추가
        let height = CGFloat(60 + (row.count / 30) * 20)
        return height
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 50 // 임의의 높이 값
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}
