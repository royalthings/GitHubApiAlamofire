//
//  DetailViewController.swift
//  GitHubApiAlamofire
//
//  Created by Dima on 4/12/19.
//  Copyright © 2019 Dima. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    
    @IBOutlet weak var webView: WKWebView!
    var strURL = ""
    fileprivate var errorURL = "https://www.cossa.ru/upload/iblock/58f/big_1111448962252_1448454582.jpg"

    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var shareItem: UIBarButtonItem!
    
    let application = UIApplication.shared
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self

        if let url = URL(string: strURL) {
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            guard let errorPage = URL(string: errorURL) else { return }
            let errorRequest = URLRequest(url: errorPage)
            webView.load(errorRequest)
        }
    }
    
    //MARK: - WKNavigationDelegate
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        application.isNetworkActivityIndicatorVisible = true
        self.goBackItem.isEnabled = false
        self.goForwardItem.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        application.isNetworkActivityIndicatorVisible = false
        if webView.canGoBack {
            self.goBackItem.isEnabled = true
        } else if webView.canGoForward {
            self.goForwardItem.isEnabled = true
        }
    }

    //MARK: - Actions
    
    @IBAction func goBackAction(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }

    @IBAction func goForwardAction(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let text = "My repository:"
        let repoWebSite = self.strURL
        let shareAll = [text, repoWebSite]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    

}
