//
//  ViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON



class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var reposData = [Model.ViewModel]()
    var responses = [Model.Response]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let url = "https://api.github.com/users/royalthings/repos"
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        Alamofire.request(url).validate(statusCode: 200..<300).validate(contentType: ["application/json"]).responseJSON(queue: utilityQueue) { response in
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                for i in 0...json.count-1 {
                    
                    var currentResponse = Model.Response()
                    
                    guard let language = json[i]["language"].string else { break }
                    guard let id = json[i]["id"].int else { break }

                    guard let name = json[i]["name"].string else { break }

                    guard let login = json[i]["owner"]["login"].string else { break }

                    let description = json[i]["description"].string

                    guard let link = json[i]["url"].string else { break }
                    
                    currentResponse.languageStr = language
                    currentResponse.idStr = "\(id)"
                    currentResponse.nameStr = name
                    currentResponse.loginStr = login
                    currentResponse.descriptionStr = description
                    currentResponse.link = link

                    self.responses.append(currentResponse)

                    print(currentResponse.languageStr!)
//                    print("id: \(json[i]["id"])")
//                    print("name: \(json[i]["name"])")
//                    print("login: \(json[i]["owner"]["login"])")
//                    print("description: \(json[i]["description"])")
                    print("-----------------")
                }
            case .failure(let error):
                print(error)
            }
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
        
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
  
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}




