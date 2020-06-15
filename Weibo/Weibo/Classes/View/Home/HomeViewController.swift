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
        
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController {
    
    /// set up base view controller UI
    override func setupUI() {
        super.setupUI()
        // setup navigation bar item
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Friend", style: .plain, target: self, action: #selector(showFriends))
    }
}
