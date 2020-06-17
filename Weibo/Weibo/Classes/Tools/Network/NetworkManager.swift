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
    static let sharedManager = NetworkManager()
    
    /// package AFNetwroking get and post request into one method
    /// - Parameters:
    ///   - method: GET/ POST
    ///   - URLString: URLString
    ///   - parameters: parameters dictionary
    ///   - completion: call back for request result (josn( array/ json), issuccess)
    func request(method: HTTPMethod = .GET, URLString: String, parameters: [String: AnyObject], completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> ()) {
        
        let success = { (task: URLSessionTask, json: Any?) -> () in
            completion(json, true)
        }
        
        let failure = { (task: URLSessionTask?, error: Error?) -> () in
            print("request failed, error: ", error)
            completion(nil, false)
        }
 
        if method == .GET {
            get(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)

        }else {
            post(URLString, parameters: parameters, headers: nil, progress: nil, success: success, failure: failure)

        }
        
    }
}
