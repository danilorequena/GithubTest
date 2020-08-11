//
//  WebViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 08/08/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var gist: Gists?

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        if let gistUrl = gist?.owner.url {
            guard let url = URL(string: gistUrl) else { return }
            let request = URLRequest(url: url)
            title = gist?.owner.ownerName
            webView.load(request)
        } else {
            guard let url = URL(string: "apple.com") else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        }
        
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.isHidden = true
        loading.stopAnimating()
    }
}
