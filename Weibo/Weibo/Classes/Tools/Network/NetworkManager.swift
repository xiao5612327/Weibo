//
//  NetworkManager.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/17/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit
import AFNetworking

enum HTTPMethod {
    case GET
    case POST
}

class NetworkManager: AFHTTPSessionManager {
    
    // alloc at static / constant
    static let sharedManager: NetworkManager = {
        let sm = NetworkManager()
        sm.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return sm
    }()
    
    lazy var user = UserAccount()
    
    var userLogon: Bool {
        return user.access_token != nil
    }
    
    func tokenRequest(method: HTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        // deal with token dictionary
        
        // 0. check token = nil, if nil return
        guard let token = user.access_token else {
            completion(nil, false)
            
            // FIXME: alert user to login
            return
        }
        
        var parameters = parameters
        // 1. check parameter is nil
        if parameters == nil {
            parameters = [String: AnyObject]()
        }
        
        // 2. set accesstoken to parameters dictionary
        parameters?["access_token"] = token as AnyObject
        
        request(method: method, URLString: URLString, parameters: parameters, completion: completion)
    }
    
    /// package AFNetwroking get and post request into one method
    /// - Parameters:
    ///   - method: GET/ POST
    ///   - URLString: URLString
    ///   - parameters: parameters dictionary
    ///   - completion: call back for request result (josn( array/ json), issuccess)
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String: AnyObject]?, completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        let success = { (task: URLSessionTask, json: Any?) -> () in
            completion(json, true)
        }
        
        let failure = { (task: URLSessionTask?, error: Error?) -> () in
            print("request failed, error: ", error)
            // handle error code 403
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
               print("Token expired or forbidden ")
                
                // FIXME: send notification
            }
            completion(nil, false)
        }
 
        if method == .GET {
            get(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)

        }else {
            post(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)

        }
        
    }
}
