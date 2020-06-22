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
    
    var id: Int64 = 0
    
    var screen_name: String?
    var profile_image_url: String?
    var verified_type: Int = 0
    var mbrank: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
