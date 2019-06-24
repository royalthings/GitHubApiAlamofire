//
//  FirstViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/16/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var profileTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTextField.becomeFirstResponder()
    }

    //MARK: - Action
    @IBAction func myButtonPressed(_ sender: Any) {
        guard let text = profileTextField.text else { return }
        if text.isEmpty {
            alertMassage(message: "Enter your profile name!")
        } else {
            let path = APIManager.Path.supplementation + text + "/repos"
            profileTextField.text = ""
            APIManager.shared.users(repositories: path) { [weak self] (response, error) in
                
                guard let posts = DataManager.array(fromArray: response as Any) else { return }
                
                let destinationVC = self?.storyboard?.instantiateViewController(withIdentifier: "repositories") as! ViewController
                destinationVC.responses = posts
                self?.navigationController?.pushViewController(destinationVC, animated: true)
                
            }
        }
    }
    //MARK: - Alert massage
    fileprivate func alertMassage(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
//MARK: - UITextFieldDelegate
extension FirstViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        profileTextField.resignFirstResponder()
        return true
    }
}
