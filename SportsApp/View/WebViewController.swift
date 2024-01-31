//
//  WebViewController.swift
//  SportsApp
//
//  Created by Mahmoud Mohamed Atrees on 17/10/2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadURL()
    }

    private func setupWebView() {
        webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        view.addSubview(webView)
    }

    private func loadURL() {
        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

}
