//
//  ListViewController.swift
//  MyMovieChart_test
//
//  Created by Sudon Noh on 2022/12/27.
//

import Foundation
import UIKit

class ListViewController: UITableViewController {
    
    // 더보기 버튼을 제어하기 위해 아울렛 변수 선언
    @IBOutlet var moreBtn: UIButton!
    
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
    
    /* 더보기 기능 */
    var page = 1
    @IBAction func more(_ sender: Any) {
        // 현재 페이지 값에 +1
        self.page += 1
        
        self.callMovieAPI()
        
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신하다.
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        NSLog("호출된 행번호: \(indexPath.row), 제목: \(row.title!)")
        
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
        /* 이미지를 직접 다운 받아서 사용하는 형식으로 속도에 문제가 있다.
        cell.thumbnail.image = UIImage(data: try! Data(contentsOf: URL(string:row.thumbnail!)!))
        */
        
        /* cell.thumbnail.image 에 있는 내용을 풀어보자면
         1) 썸네일 경로를 인자값으로 하는 URL 객체 생성
            let url: URL! = URL(string: row.thumbnail!)
         
         2) 이미지를 읽어와 Data 객체에 저장
            let imageData = try! Data(contentsOf: url)
         
         3) UIImage 객체를 생성해 아울렛 변수의 image 속성에 대입
            cell.thumbnail.image = UIImage(data:imageData)
        */
        
        // 이미지를 미리 내려받은 배열에서 꺼내서 사용하는 방식으로 수정
        DispatchQueue.main.async(execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    // 데이터 호출을 위한 코드
    override func viewDidLoad() {
        self.callMovieAPI()
    }
    
    func callMovieAPI() {
        // 호핀 API 호출을 위한 URI 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=10&genreId=&order=releasedateasc"
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
                
                /* 썸네일 이미지 URL을 이용하여 이미지를 읽어들인 다음 movieVO 객체에 UIImage를 저장하는 코드 */
                // 웹 상에 있는 이미지를 읽어와 UIImage 객체로 생성
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data: imageData)
                
                
                self.list.append(mvo)
                
                let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
                if (self.list.count >= totalCount) {
                    self.moreBtn.isHidden = true
                }
            }
        } catch {
            NSLog("Parse Error!!")
        }
    }
    
    // 썸네일 이미지를 처리하는 커스텀 메소드를 정의, 이 메소드 내부에서 메모이제이션 기법을 적용
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션: 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData)
            return mvo.thumbnailImage!
        }
    }
}
