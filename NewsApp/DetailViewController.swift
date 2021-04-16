//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Ingvar on 16.04.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKNavigationDelegate {

    private var webView: WKWebView!
    var url: URL?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = self.url else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
