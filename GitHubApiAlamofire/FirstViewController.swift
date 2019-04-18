//
//  FirstViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/16/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController, UITextFieldDelegate {

    let gitUrl = "https://api.github.com/users/"
    
    @IBOutlet weak var profileTextField: UITextField!

    @IBOutlet weak var myButton: UIButton!
    
    var responses = [Models]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileTextField.becomeFirstResponder()
    
    }

    @IBAction func myButtonPressed(_ sender: Any) {
        
        if (profileTextField.text?.isEmpty)! {
            print("Enter your profile name!")
        } else {
            let gitProfile = gitUrl + profileTextField.text! + "/repos"
                        
            guard canOpenURL(string: gitProfile) else { return }
         
            Alamofire.request(gitProfile).responseJSON { response in
                guard response.result.isSuccess else {
                    print("Ошибка при запросе данных \(String(describing: response.result.error))")
                    return
                }
                 guard let arrayOfItem = response.result.value as? [[String: AnyObject]]
                    else {
                        print("Не могу перевести в массив")
                        return
                }
                for itm in arrayOfItem {
                    let item = Models(languageStr: itm["language"] as? String, idStr: itm["id"] as? Int, nameStr: itm["name"] as? String, loginStr: itm["owner"]!["login"] as? String, descriptionStr: itm["description"] as? String, linkStr: itm["html_url"] as? String)
                    self.responses.append(item)
                }
                DispatchQueue.main.async {
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! ViewController
                    destinationVC.responses2 = self.responses
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
            self.profileTextField.text = ""
            self.responses.removeAll()
        }
    }

    func canOpenURL(string: String?) -> Bool {
        guard let urlString = string else { return false }
        guard let url = URL(string: urlString) else { return false }
        if !UIApplication.shared.canOpenURL(url) { return false }

        let regEx = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let predicate = NSPredicate(format: "SELF MATCHES %@", argumentArray: [regEx])
        return predicate.evaluate(with:string)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.profileTextField.resignFirstResponder()
        return true
    }

}
