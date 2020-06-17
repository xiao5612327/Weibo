//
//  NetworkManager+Extension.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/17/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

// MARK: package weibo open resounce api
extension NetworkManager {
    
    func statusList(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        // use network manager to request data from weibo open resouce
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let accessToken = "2.006x3OyGLjRemC0c1b20b1c50PvsR5"
        
        let params = ["access_token": accessToken]
        
        request(URLString: urlString, parameters: params as [String : AnyObject]) { (json, success) in

            let result = (json as! [String: AnyObject])["statuses"] as? [[String: AnyObject]]
            completion(result, success)
        }
    }
}
