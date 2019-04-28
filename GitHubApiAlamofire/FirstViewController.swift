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

    fileprivate let gitUrl = "https://api.github.com/users/"
    
    @IBOutlet weak var profileTextField: UITextField!

    @IBOutlet weak var myButton: UIButton!
    
    var responses = [Models]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        profileTextField.becomeFirstResponder()
    
    }

    @IBAction func myButtonPressed(_ sender: Any) {
        
        if profileTextField.text == "" {
            print("Enter your profile name!")
        } else {
            let gitProfile = gitUrl + profileTextField.text! + "/repos"
            
            profileTextField.text = ""
            responses.removeAll()

            guard canOpenURL(string: gitProfile) else { return }

            Alamofire.request(gitProfile).responseJSON { response in
                
                switch response.result {
                case .success(let value):
                    guard let posts = Models.getArray(from: value) else { return }
                    print(posts)
    
                    DispatchQueue.main.async {
    
                        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! ViewController
                        destinationVC.responses2 = posts
                        self.navigationController?.pushViewController(destinationVC, animated: true)
                    }
                    
                case .failure(let error):
                    print(error)
                }

            }
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


