//
//  StatusViewModel.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/21/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

class StatusViewModel: CustomStringConvertible {
    
    var description: String {
        return status.description
    }
    
    var status: Status
    
    init(status: Status) {
        self.status = status
    }
}
