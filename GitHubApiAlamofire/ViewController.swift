//
//  ViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var responses = [DataManager]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? RepoTableViewCell else { return UITableViewCell() }
        configCell(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = responses[indexPath.row]
        guard let objWeb = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailViewController else { return }
        
        let itemLink = item.linkStr
        objWeb.strURL = itemLink
        navigationController?.pushViewController(objWeb, animated: true)
    }
    
    private func configCell(cell: RepoTableViewCell, for indexPath: IndexPath) {
        let item = responses[indexPath.row]

        cell.languageLable?.text = "Language: \(item.languageStr)"
        cell.idLable?.text = "ID: \(item.idStr)"
        cell.nameLable?.text = "Name: \(item.nameStr)"
        cell.createdAtLable?.text = "Create at: \(item.createdAtStr)"
        cell.descriptionLable?.text = "Description: \(item.descriptionStr)"

    }

}
