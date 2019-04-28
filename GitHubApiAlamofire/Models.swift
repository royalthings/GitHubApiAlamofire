//
//  Models.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit

struct Models {
    var languageStr: String
    var idStr: Int
    var nameStr: String
    var createdAtStr: String
    var descriptionStr: String
    
    var linkStr: String
    
    init?(json: [String: Any]) {
        
        guard let language = json["language"] as? String,
              let id = json["id"] as? Int,
              let name = json["name"] as? String,
              let createdAt = json["created_at"] as? String,
              let description = json["description"] as? String,
              let link = json["html_url"] as? String
        else { return nil }
        
        self.languageStr = language
        self.idStr = id
        self.nameStr = name
        self.createdAtStr = createdAt
        self.descriptionStr = description
        self.linkStr = link
    }
    
    static func getArray(from jsonArray: Any) -> [Models]? {
        guard let jsonArray = jsonArray as? Array<[String: Any]> else { return nil }
        var posts: [Models] = []
        
        for jsonObject in jsonArray {
            if let post = Models(json: jsonObject) {
                posts.append(post)
            }
        }
        return posts
    }
    
}

