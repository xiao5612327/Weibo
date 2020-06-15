//
//  Bundle+Extensions.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/15/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

extension Bundle {
    
    /// getting namespace for this project. for creating view controller use
    var namespace: String {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
