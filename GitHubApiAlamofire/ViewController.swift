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

    var responses2 = [Models]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses2.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! RepoTableViewCell
        configCell(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = responses2[indexPath.row]
        let objWeb = self.storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        objWeb.strURL = item.linkStr!
        self.navigationController?.pushViewController(objWeb, animated: true)
    }
    
    private func configCell(cell: RepoTableViewCell, for indexPath: IndexPath) {
        let item = responses2[indexPath.row]
        
        if let language = item.languageStr, let id = item.idStr, let name = item.nameStr, let login = item.loginStr, let description = item.descriptionStr {
            cell.languageLable?.text = "Language: \(language)"
            cell.idLable?.text = "ID: \(id)"
            cell.nameLable?.text = "Name: \(name)"
            cell.loginLable?.text = "Login: \(login)"
            cell.descriptionLable?.text = "Description: \(description)"
        }

    }

}
