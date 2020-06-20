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
        
        guard let uid = userAccount.uid else {
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

// MARK: user info
extension NetworkManager {
    
    func loadUserInfo(completion: @escaping (_ dict: [String: AnyObject])->()) {
        
        guard let uid = userAccount.uid else {
            return
        }
        let urlString = "https://api.weibo.com/2/users/show.json"
        let params = ["uid": uid]
        
        tokenRequest(URLString: urlString, parameters: params as [String: AnyObject]) { (json, success) in
            completion(json as? [String : AnyObject] ?? [:])
        }
    }
}

extension NetworkManager {
    
    
    /// request for access token
    /// - Parameters:
    ///   - code: OAuth code
    ///   - completion: return successfull
    func loadAccessToken(code: String, completion: @escaping (_ success: Bool)->()) {
        let urlStirng = "https://api.weibo.com/oauth2/access_token"
        
        let parameters = ["client_id": AppKey,
                          "client_secret": AppSecret,
                          "grant_type": "authorization_code",
                          "code": code,
                          "redirect_uri": RedirectURL]
        
        
        request(method: .POST, URLString: urlStirng, parameters: parameters as [String : AnyObject]) { (json, success) in
            
            guard let json = json as? [String: AnyObject] else {
                completion(false)
                return
            }
            
            self.userAccount.yy_modelSet(with: json)
            
            self.loadUserInfo { (dict) in
                
                self.userAccount.yy_modelSet(with: dict)
                self.userAccount.saveAccount()
                completion(true)
            }
            
        }
        
    }
}
