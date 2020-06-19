//
//  UserAccount.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/18/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    
    // access token
    var access_token: String? = "2.006x3OyGLjRemC6b9a8eb27d0Ei2C9"
    
    // user id
    var uid: String? = "6386801995"
    
    // access token expire time
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    
    var expiresDate: Date?
    
    override var description: String {
        return yy_modelDescription()
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
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []), let fileName = ("useraccount.json" as NSString).cz_appendDocumentDir() else {
            return
        }
        
        // 3. write to disk
        (data as NSData).write(toFile: fileName, atomically: true)
        
        
        
        
        
    }
}
