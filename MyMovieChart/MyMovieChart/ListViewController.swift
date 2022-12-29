//
//  ListViewController.swift
//  MyMovieChart_test
//
//  Created by Sudon Noh on 2022/12/27.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    // 오픈 API 불러오지 않은 상태에서 실행할 때 1
    // var dataset = [
    //     ("다크나이트", "영웅물에 철학에 음악까지 더해져 예술이 되다.", "2008-09-04", 8.95, "darknight.jpeg"),
    //     ("호우시절", "때를 알고 내리는 좋은 비", "2009-10-08", 7.31, "rain.jpeg"),
    //     ("말할 수 없는 비밀", "여기서 너까지 다섯 걸음", "2015-05-07", 9.19, "secret.jpeg")
    // ]
    
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        
        // 오픈 API 불러오지 않은 상태에서 실행할 때 2
        // for (title, desc, opendate, rating, thumbnail) in self.dataset {
        //     let mvo = MovieVO()
        //     mvo.title = title
        //     mvo.description = desc
        //     mvo.opendate = opendate
        //     mvo.rating = rating
        //     mvo.thumbnail = thumbnail
        //     datalist.append(mvo)
        // }
        return datalist
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        // 아래 코드는 Subtitle 및 Custom으로 설정한 경우
        // let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        /* 여기부터는 Prototype Cell Style을 Subtitle로 설정한 경우
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = row.description
        여기까지 */
        
        /* 여기부터는 Prototype Cell Style을 Custom으로 설정한 경우
        let title = cell.viewWithTag(101) as? UILabel
        let desc = cell.viewWithTag(102) as? UILabel
        let opendate = cell.viewWithTag(103) as? UILabel
        let rating = cell.viewWithTag(104) as? UILabel
        
        title?.text = row.title
        desc?.text = row.description
        opendate?.text = row.opendate
        rating?.text = "\(row.rating!)"
        여기까지 */
        
        /* 여기부터는 Custom Class로 Prototype Cell 제어하는 경우 */
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
        cell.thumbnail.image = UIImage(data: try! Data(contentsOf: URL(string:row.thumbnail!)!))
        /* cell.thumbnail.image 에 있는 내용을 풀어보자면
         1) 썸네일 경로를 인자값으로 하는 URL 객체 생성
            let url: URL! = URL(string: row.thumbnail!)
         
         2) 이미지를 읽어와 Data 객체에 저장
            let imageData = try! Data(contentsOf: url)
         
         3) UIImage 객체를 생성해 아울렛 변수의 image 속성에 대입
            cell.thumbnail.image = UIImage(data:imageData)
        */

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    // 데이터 호출을 위한 코드
    override func viewDidLoad() {
        // 호핀 API 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=1&count=10&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // REST API 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과를 로그로 출력
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
        // JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options:[]) as! NSDictionary
            print(type(of: apiDictionary)) // __NSSingleEntryDictionaryI
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                self.list.append(mvo)
            }
        } catch { }
    }
}
