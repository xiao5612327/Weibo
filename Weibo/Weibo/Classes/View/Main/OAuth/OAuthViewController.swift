//
//  OAuthViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/18/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(AppKey)&redirect_uri=\(RedirectURL)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    private func setupNavigationBar() {
        title = "Log in Weibo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", target: self, action: #selector(handleBack), isBackButton: true)
    }
    
    @objc private func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
