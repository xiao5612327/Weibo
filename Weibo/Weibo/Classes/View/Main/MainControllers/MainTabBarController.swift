//
//  MainViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import SVProgressHUD

/// main view controller
class MainTabBarController: UITabBarController {

    // timer
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChildController()
        setupComposeButton()
        
        setupTimer()
        delegate = self
        
        regitsterNotifcation()
    }
    
    // important to destroy timer
    deinit {
        timer?.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func regitsterNotifcation() {
        // register notification
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(UserShouldLoginNotification), object: nil)
    }
    
    @objc private func userLogin(n: Notification) {
        
        // check if n.object has value
        // if no alert user to re log in
        var time = DispatchTime.now()
        
        if n.object != nil {
            SVProgressHUD.setDefaultMaskType(.gradient)
            SVProgressHUD.showInfo(withStatus: "Please log in.")
            time = DispatchTime.now() + 2
        }
        
        DispatchQueue.main.asyncAfter(deadline: time) {
            SVProgressHUD.setDefaultMaskType(.clear)
            let vc = OAuthViewController()
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }

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

// MARK: tab bar delegate
extension MainTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let idx = (children as NSArray).index(of: viewController)
        
        if selectedIndex == 0 && idx == selectedIndex {
            let nav = children[0] as! UINavigationController
            let vc = nav.children[0] as! HomeViewController
            
            vc.tableView?.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        
        
        return !viewController.isMember(of: UIViewController.self)
    }

}


// MARK: timer method setup timer
extension MainTabBarController {
    
    func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        
        if !NetworkManager.sharedManager.userLogon {
            return
        }
        
        NetworkManager.sharedManager.unreadCount { (count) in
            print(count)
            self.tabBar.items?.first?.badgeValue = count == 0 ? nil : "\(count)"
            UIApplication.shared.applicationIconBadgeNumber = count
        }
    }
}

//Mark: Setup main screen
extension MainTabBarController {
    
    
    /// set up custom compose button
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        let count = CGFloat(children.count)
        let w = tabBar.bounds.width / count
        
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        composeButton.addTarget(self, action: #selector(compseStatus), for: .touchUpInside)
    }
    
    /// set up all child controllers
    private func setupChildController() {
        // 0. get application setting json data from disk
        let docDic = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let jsonPath = (docDic as NSString).appendingPathComponent("main.json")
        
        var data = NSData(contentsOfFile: jsonPath)
        
        if data == nil {
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        // get setup ui json data from bundle
        // 1. get path from bundle for ui json file
        // 2. load nsdata
        // 3. deserialization
        guard let array = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as? [[String: Any]] else {
            return
        }
        
        // loop through array to create viewcontrollers
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


