//
//  BaseViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

// OC does not support mutilpl Inherite, instead using protocal
// in swift, more similar to mutilple inherite
class BaseViewController: UIViewController {

    // User log in status
    var visitorInfoDictionary: [String: String]?
    
    // MARK: - tableview property
    var tableView: UITableView?
    var refreshController: UIRefreshControl?
    var isPullUp = false
    
    // custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: topStatusBarHeight, width: UIScreen.cz_screenWidth(), height: 44))
    
    lazy var statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: topStatusBarHeight))
    
    // custom navigation item
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        NetworkManager.sharedManager.userLogon ? loadData() : ()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: NSNotification.Name(UserLoginSuccessNotification), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /// method to prepare data
    @objc func loadData() {
        refreshController?.endRefreshing()
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }

}

// MARK: visitor view buttons target
extension BaseViewController {
    
    // log in success. change ui
    @objc private func loginSuccess() {
        
        // reset navigation bar items
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        
        // when using view's getter. if view == nil,
        // view controller view re-call loadView -> viewDidLoad()
        view = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func handleRegister() {

    }
    
    @objc func handleLogin() {
        NotificationCenter.default.post(name: NSNotification.Name(UserShouldLoginNotification), object: nil)
    }
}

// Setup Main UI
extension BaseViewController {
    
    /// set up base view controller UI
    private func setupUI() {
        view.backgroundColor = UIColor.white
        
        setupNavigationBar()
        NetworkManager.sharedManager.userLogon ? setupTableView() : setupVisitorView()
    }
    
    private func setupVisitorView() {
        
        let visitoerView = VisitorView(frame: view.bounds)
        visitoerView.visitorInfo = visitorInfoDictionary
        visitoerView.registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        visitoerView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        view.insertSubview(visitoerView, belowSubview: navigationBar)
        
        // set up navigation bar item
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Register", target: self, action: #selector(handleRegister), isBackButton: false)
        navItem.rightBarButtonItem = UIBarButtonItem(title: "Login", target: self, action: #selector(handleLogin))
    }
    
    /// set up table view, when user login
    @objc func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        tableView?.contentInsetAdjustmentBehavior = .never
        // set up datasource and delegate
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // set table view content insert
        let insert = UIEdgeInsets(top: topStatusBarHeight + navigationBar.bounds.height, left: 0, bottom: (tabBarController?.tabBar.frame.height ?? 0), right: 0)
        tableView?.contentInset = insert
        tableView?.scrollIndicatorInsets = tableView!.contentInset
        
        // setup refresh controller
        refreshController = UIRefreshControl()
        tableView?.refreshControl = refreshController
        refreshController?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    fileprivate func setupNavigationBar() {
        // add navigationbar
        view.addSubview(statusBarView)
        view.addSubview(navigationBar)
        statusBarView.backgroundColor = .white
        navigationBar.backgroundColor = .white
        navigationBar.items = [navItem]
        
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        navigationBar.tintColor = .orange
    }
}


// MARK: table view data source, and delegate
extension BaseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    // Base view controller only respond for prepare method, children view controllers
    // should implement real method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // when user reach to end of table view, refresh data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // get section and row
        let section = tableView.numberOfSections - 1
        let row = indexPath.row
        
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullUp {
            print("is pull up")
            isPullUp = true
            
            // begin load more data
            loadData()
        }
        
    }
}
