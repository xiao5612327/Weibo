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
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // Check view controller is not bottom of children viewcontrollers
        // because when we initial tabbar view controllers with navigation controllers
        // pushViewController will be called
        if !children.isEmpty {
            viewController.hidesBottomBarWhenPushed = true
            
            if let vc = viewController as? BaseViewController {
                
                let title = viewControllers.count == 1 ? children.first?.title ?? "Back" : "Back"
                
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent), isBackButton: true)
            }

        }
        
        
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func popToParent() {
        popViewController(animated: true)
    }
}
