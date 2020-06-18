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
    var id: Int64 = 0
    
    // text info for weibo
    var text: String?
    
    override var description: String {
        return yy_modelDescription()
    }
}
