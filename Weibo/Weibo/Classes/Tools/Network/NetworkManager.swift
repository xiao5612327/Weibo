//
//  NetworkManager.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/17/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkManager: AFHTTPSessionManager {
    
    // alloc at static / constant
    static let sharedManager = NetworkManager()
    
    
}
