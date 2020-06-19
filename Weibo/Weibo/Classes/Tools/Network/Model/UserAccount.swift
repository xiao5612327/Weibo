//
//  UserAccount.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/18/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    
    // access token
    var access_token: String? = "2.006x3OyGLjRemC6b9a8eb27d0Ei2C9"
    
    // user id
    var uid: String? = "6386801995"
    
    // access token expire time
    var expires_in: TimeInterval = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
