//
//  HomeViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIColor.cz_random()
        // Do any additional setup after loading the view.
    }
    
    
    /// target func for friend button
    @objc private func showFriends() {
        
        let vc = BaseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    
    /// set up base view controller UI
    override func setupUI() {
        super.setupUI()
        
        // swift call OC return instanceType method cant know if it is optional
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Friend", target: self, action: #selector(showFriends))
    }
}
