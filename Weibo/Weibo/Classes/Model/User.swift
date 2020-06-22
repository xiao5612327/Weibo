//
//  User.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/21/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

// User model
class User: NSObject {
    
    @objc var id: Int64 = 0
    
    @objc var screen_name: String?
    @objc var profile_image_url: String?
    @objc var verified_type: Int = 0
    @objc var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
