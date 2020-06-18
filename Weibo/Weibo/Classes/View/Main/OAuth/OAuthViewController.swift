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
        //https://api.weibo.com/oauth2/authorize?client_id=2551131061&redirect_uri=http://baidu.com

        guard let url = URL(string: urlString) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        webView.load(request)
    }
    
    private func setupNavigationBar() {
        title = "Log in Weibo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", target: self, action: #selector(handleBack), isBackButton: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Auto Fill", target: self, action: #selector(autoFill))
    }
    
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value = 'xiao5612327';" + "document.getElementById('passwd').value = 'aaaa'"
        
        webView.evaluateJavaScript(js) { (json, error) in
            print(error)
            print(json)
        }
    } 
    
    @objc private func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
