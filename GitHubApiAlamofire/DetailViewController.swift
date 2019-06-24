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

    
    var strURL = ""
    fileprivate let errorURL = "https://www.cossa.ru/upload/iblock/58f/big_1111448962252_1448454582.jpg"

    //MARK: - Outlet
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var goBackItem: UIBarButtonItem!
    @IBOutlet weak var goForwardItem: UIBarButtonItem!
    @IBOutlet weak var shareItem: UIBarButtonItem!
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
        AppDelegate().appDelegate().isNetworkActivityIndicatorVisible = true
        
        //application.isNetworkActivityIndicatorVisible = true
        goBackItem.isEnabled = false
        goForwardItem.isEnabled = false
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        AppDelegate().appDelegate().isNetworkActivityIndicatorVisible = false
        if webView.canGoBack {
            goBackItem.isEnabled = true
        } else if webView.canGoForward {
            goForwardItem.isEnabled = true
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
        let text = "My repository:".localized()
        let repoWebSite = strURL
        let shareAll = [text, repoWebSite]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = view
        present(activityViewController, animated: true, completion: nil)
    }

}
extension String {
    func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }
}
