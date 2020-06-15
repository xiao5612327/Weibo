//
//  BaseViewController.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/14/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

}

extension BaseViewController {
    
    /// set up base view controller UI
    @objc func setupUI() {
        view.backgroundColor = UIColor.cz_random()
    }
}
