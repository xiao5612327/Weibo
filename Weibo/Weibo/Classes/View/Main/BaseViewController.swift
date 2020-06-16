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

    var tableView: UITableView?
    
    // custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: topStatusBarHeight, width: UIScreen.cz_screenWidth(), height: 44))
    
    lazy var statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: topStatusBarHeight))
    
    // custom navigation item
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }

}

// Setup Main UI
extension BaseViewController {
    
    /// set up base view controller UI
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        
        setupNavigationBar()
        setupTableView()
    }
    
    
    /// set up table view
    fileprivate func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        view.insertSubview(tableView!, belowSubview: navigationBar)
        
        // set up datasource and delegate
        tableView?.dataSource = self
        tableView?.delegate = self
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
}
