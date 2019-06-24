//
//  Models.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit

struct DataManager {
    var languageStr: String
    var idStr: Int
    var nameStr: String
    var createdAtStr: String
    var descriptionStr: String
    
    var linkStr: String
    
    init?(json: [String: Any]) {
        
        if let language = json["language"] as? String {
            self.languageStr = language
        } else {
            self.languageStr = "No Value"
        }
        
        if let description = json["description"] as? String {
            self.descriptionStr = description
        } else {
            self.descriptionStr = "No Value"
        }
        
        self.idStr = json["id"] as! Int
        self.nameStr = json["name"] as! String
        self.linkStr = json["html_url"] as! String
        self.createdAtStr = json["created_at"] as! String
    }
    
    static func array(fromArray: Any) -> [DataManager]? {
        guard let jsonArray = fromArray as? [[String: Any]] else { return nil }
        var posts: [DataManager] = []
        
        for jsonObject in jsonArray {
            if let post = DataManager(json: jsonObject) {
                posts.append(post)
            }
        }
        return posts
        
    }
    
}

