//
//  UserAccount.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/18/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

private let accountFile:NSString = "useraccount.json"


class UserAccount: NSObject {
    
    // access token
    @objc var access_token: String? = "2.006x3OyGLjRemC6b9a8eb27d0Ei2C9"
    
    // user id
    @objc var uid: String? = "6386801995"
    
    // access token expire time
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    @objc var expiresDate: Date?
 
    @objc var screen_name: String? = "user6386801995"
    @objc var avatar_large: String? = "https://tvax4.sinaimg.cn/crop.0.0.689.689.180/006YemXply8fmqp32vs7mj30j50j643p.jpg?KID=imgbed,tva&Expires=1592809427&ssig=B2A2Taxm79"
    
    override var description: String {
        return yy_modelDescription()
    }
    
    override init() {
        super.init()
        
        // get user account json file from disk
        guard let path = accountFile.cz_appendDocumentDir(), let data = NSData(contentsOfFile: path), let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject] else {
            
            return
        }
        
        // convert json data user account object
        yy_modelSet(with: dict)
        
        // check access token is expired
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("token is expired")
            
            access_token = nil
            uid = nil
            
            try? FileManager.default.removeItem(atPath: path)
        }
    }
    
    /*
     the way to save user account
     1. setting: small
     2. save to disk (file / plit / json):
     3. database ( FMDB/Corebase):
     4. keychain (small/auto encrpt - need framework SSKeychain):
     
     */
    func saveAccount() {
        
        // 1. model convert to dictionary
        var dict = self.yy_modelToJSONObject() as? [String: AnyObject] ?? [:]
        
        // remove unused key
        _ = dict.removeValue(forKey: "expires_in")
        
        // 2. dictionary to json data
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []), let fileName = accountFile.cz_appendDocumentDir() else {
            return
        }
        
        // 3. write to disk
        (data as NSData).write(toFile: fileName, atomically: true)
    }
}
