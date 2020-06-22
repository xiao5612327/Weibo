//
//  OAuthViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/18/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD

class OAuthViewController: UIViewController {

    private lazy var webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        
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
        
        webView.evaluateJavaScript(js) { (json, error) in }
    }
    
    @objc private func handleBack() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }

}

extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
       
        let url = navigationAction.request.url
        if url?.absoluteString.hasPrefix(RedirectURL) == false {
            decisionHandler(WKNavigationActionPolicy.allow)
            return
        }
        
        
        if url?.query?.hasPrefix("code=") == false {
            decisionHandler(WKNavigationActionPolicy.cancel)
            handleBack()
            return
        }
        
        let code = url?.query?.substring(from: "code=".endIndex) ?? ""
        
        // request access_token
        NetworkManager.sharedManager.loadAccessToken(code: code) { (success) in
            if success {
                SVProgressHUD.showInfo(withStatus: "Log in successed!")
                
                NotificationCenter.default.post(name: NSNotification.Name(UserLoginSuccessNotification), object: nil)
                
                self.handleBack()
            }else {
                SVProgressHUD.showInfo(withStatus: "Log in failed!")
            }
        }
        
        decisionHandler(WKNavigationActionPolicy.cancel)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SVProgressHUD.show()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SVProgressHUD.dismiss()
    }
}
