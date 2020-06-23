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
    
    var memberIcon: UIImage?
    var vipIcon: UIImage?
    
    init(status: Status) {
        self.status = status
        
        if status.user?.mbrank ?? 0 > 0 && status.user?.mbrank ?? 0 < 7 {
            let imageName = "common_icon_membership_level\(status.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        switch status.user?.verified_type {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
    }
}
