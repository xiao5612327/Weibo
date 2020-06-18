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
    }
    
    private func setupNavigationBar() {
        title = "Log in Weibo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", target: self, action: #selector(handleBack), isBackButton: true)
    }
    
    @objc private func handleBack() {
        dismiss(animated: true, completion: nil)
    }

}
