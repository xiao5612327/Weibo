//
//  BaseViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

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
