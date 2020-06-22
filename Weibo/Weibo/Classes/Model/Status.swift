//
//  Status.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/17/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import YYModel

class Status: NSObject {
    
    // Int64
    @objc var id: Int64 = 0
    
    // text info for weibo
    @objc var text: String?
    
    @objc var user: User?
    
    override var description: String {
        return yy_modelDescription()
    }

}
