//
//  WebViewController.swift
//  GitAppTest
//
//  Created by Danilo Requena on 08/08/20.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var gist: Gists!

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadWebView()
    }
    
    func loadWebView() {
        let url = URL(string: gist.owner.url)
        let request = URLRequest(url: url!)
        title = gist.owner.ownerName
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }
}
