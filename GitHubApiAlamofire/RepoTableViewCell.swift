//
//  RepoTableViewCell.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var languageLable: UILabel?
    @IBOutlet weak var idLable: UILabel?
    @IBOutlet weak var nameLable: UILabel?
    @IBOutlet weak var loginLable: UILabel?
    @IBOutlet weak var descriptionLable: UITextView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(language: String, id: String, name: String, login: String, description: String) {
        
        languageLable?.text = language
        idLable?.text = id
        nameLable?.text = name
        loginLable?.text = login
        descriptionLable?.text = description
    }


}
