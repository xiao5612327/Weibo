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
    var access_token: String?
    
    // user id
    var uid: String?
    
    // access token expire time
    var expires_in: TimeInterval = 0
    
    override var description: String {
        return yy_modelDescription()
    }
}
