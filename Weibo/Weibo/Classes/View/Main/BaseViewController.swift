//
//  BaseViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // custom navigation bar
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: topStatusBarHeight, width: UIScreen.cz_screenWidth(), height: 64))
    
    // custom navigation item
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(topStatusBarHeight)
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
        
        // add navigationbar
        view.addSubview(navigationBar)
        navigationBar.backgroundColor = .white
        navigationBar.items = [navItem]
        
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
    }
}
