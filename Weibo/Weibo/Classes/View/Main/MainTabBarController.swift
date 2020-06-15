//
//  MainViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit


/// main view controller
class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildController()
    }
    
}

//Mark: Setup main screen
extension MainTabBarController {
    
    
    /// set up all child controllers
    private func setupChildController() {
        let array = [
            ["clsName": "HomeViewController", "title": "Home", "imageName": ""]
        ]
        
        var arrayM = [UIViewController]()
        for dic in array {
            arrayM.append(controller(dict: dic))
        }
        
        viewControllers = arrayM
    }
    
    
    /// Using dictionary to create child view controller
    /// - Parameter dict: dictionary info[claName, title, imageName
    /// - return: UIViewController
    private func controller(dict: [String: String]) -> UIViewController {
        
        // 1. get dictionary info
        guard let claName = dict["clsName"], let title = dict["title"], let imageName = dict["imageName"], let cls = NSClassFromString(Bundle.main.namespace + "." + claName) as? UIViewController.Type else {
            return UIViewController()
        }
        
        //2. create view controller
        //1> convert clsName to class
        let vc = cls.init()
        
        vc.title = title
        
        let nav = MainNavigationController(rootViewController: vc)
        return nav
    }
}
