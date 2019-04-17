//
//  DetailViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    var srtURL = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: srtURL)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }
    



}
