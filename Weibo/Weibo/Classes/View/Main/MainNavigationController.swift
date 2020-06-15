//
//  MainNavigationController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // hide default navigationBar
        navigationBar.isHidden = true
        print(navigationBar.frame)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // Check view controller is not bottom of children viewcontrollers
        // because when we initial tabbar view controllers with navigation controllers
        // pushViewController will be called
        if !children.isEmpty {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
