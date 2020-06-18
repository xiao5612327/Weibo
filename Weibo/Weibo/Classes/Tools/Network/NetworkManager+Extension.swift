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
    
    
    /// Get json data from weibo
    /// - Parameters:
    ///   - since_id: get post before this id
    ///   - max_id: get post after this id
    ///   - completion: return result
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        // use network manager to request data from weibo open resouce
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        let parameters = ["since_id": since_id, "max_id": max_id > 0 ? max_id - 1 : 0]
        
        tokenRequest(URLString: urlString, parameters: parameters as [String : AnyObject]) { (json, success) in
            guard let json = json else {
                completion(nil, success)
                return
            }
            let result = (json as! [String: AnyObject])["statuses"] as? [[String: AnyObject]]
            completion(result, success)
        }
    }
    
    // return weibo unread count
    func unreadCount(completion: @escaping (_ count: Int) -> ()) {
        
        guard let uid = uid else {
            return
        }
        let urlString = "https://api.weibo.com/2/remind/unread_count.json"
        let parameters = ["uid": uid]
        
        tokenRequest(URLString: urlString, parameters: parameters as [String : AnyObject]) { (json, isSuccess) in
            
            let dic = json as? [String: AnyObject]
            let count = dic?["status"] as? Int ?? 0
            completion(count)
        }
    }
}
