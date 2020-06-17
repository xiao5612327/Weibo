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
        setupComposeButton()
    }
    
    
    /// using code to controller device interf aceOrientation.
    // why here? when parent viewcontroller apply this one
    // all children view controller will also apply.
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - observing button
    //  
    @objc fileprivate func compseStatus() {
        
    }
    
    //MARK: - private button
    /// custom button
    private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")

}

//Mark: Setup main screen
extension MainTabBarController {
    
    
    /// set up custom compose button
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(children.count)
        let w = tabBar.bounds.width / count - 1
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        composeButton.addTarget(self, action: #selector(compseStatus), for: .touchUpInside)
    }
    
    /// set up all child controllers
    private func setupChildController() {
        let array: [[String: Any]] = [
            ["clsName": "HomeViewController", "title": "Home", "imageName": "home",
             "visitorInfo": ["imageName": "", "message": "Follow people, find out what is going on."]],
            ["clsName": "MessageViewController", "title": "Message", "imageName": "message_center",
             "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "Log in, people can comment on your post, send message to you, and recevie notification."]],
            ["clsName": "UIViewController"],
            ["clsName": "DiscoverViewController", "title": "Discover", "imageName": "discover",
            "visitorInfo": ["imageName": "visitordiscover_image_message", "message": "Log in, you will get all newest, hottest Weibo, and never missing with fashion."]],
            ["clsName": "ProfileViewController", "title": "Profile", "imageName": "profile",
            "visitorInfo": ["imageName": "visitordiscover_image_profile", "message": "Log in, your Weibo, photos, personal information will be displayed here. Show yourself!"]],
        ]
        
        //(array as NSArray).write(toFile: "/Users/mac/Desktop/Demo.plist", atomically: true)
        
        var arrayM = [UIViewController]()
        for dic in array {
            arrayM.append(controller(dict: dic))
        }
        
        viewControllers = arrayM
    }
    
    
    /// Using dictionary to create child view controller
    /// - Parameter dict: dictionary info[claName, title, imageName
    /// - return: UIViewController
    private func controller(dict: [String: Any]) -> UIViewController {
        
        // 1. get dictionary info
        guard let claName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + claName) as? BaseViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String: String] else {
            return UIViewController()
        }
        
        //2. create view controller
        //1> convert clsName to class
        let vc = cls.init()
        
        vc.title = title
        vc.visitorInfoDictionary = visitorDict
        
        //3. set tab bar image icon
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        
        //4. setting tab bar title color
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.orange], for: .selected)
        vc.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], for: .normal)
        let nav = MainNavigationController(rootViewController: vc)
        return nav
    }
}
