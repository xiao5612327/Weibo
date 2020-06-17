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
        
        tokenRequest(URLString: urlString, parameters: nil) { (json, success) in
            guard let json = json else {
                completion(nil, success)
                return
            }
            let result = (json as! [String: AnyObject])["statuses"] as? [[String: AnyObject]]
            completion(result, success)
        }
    }
}
