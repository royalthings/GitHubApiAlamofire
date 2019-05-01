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

    @IBOutlet weak var profileTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    typealias Closure = (_ response: Any?, _ error: Error?) -> Void

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTextField.becomeFirstResponder()
    }

    @IBAction func myButtonPressed(_ sender: Any) {

        if profileTextField.text == "" {
            print("Enter your profile name!")
        } else {
            APIManager.Path.environments = profileTextField.text! + "/repos"
            let path = APIManager.Path.environments
            profileTextField.text = ""
            APIManager.shared.method(forRepository: path) { (response, error) in
                
                guard let posts = Models.getArray(from: response as Any) else { return }
                DispatchQueue.main.async {
                    let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "secondVC") as! ViewController
                    destinationVC.responses = posts
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                }
            }
        }
    }
    
   
    //MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.profileTextField.resignFirstResponder()
        return true
    }
  
}
