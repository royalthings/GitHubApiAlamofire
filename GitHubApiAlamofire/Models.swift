//
//  Models.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit

enum Model {
    struct Requesr {
        
    }
    struct Response {
        var languageStr: String!
        var idStr: String!
        var nameStr: String!
        var loginStr: String!
        var descriptionStr: String?
        
        var link: String?
    }
    struct ViewModel {
        var languageStr: String!
        var idStr: String!
        var nameStr: String!
        var loginStr: String!
        var descriptionStr: String?
    }
}
