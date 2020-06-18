//
//  StatusListViewModel.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/17/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

// Weibo list view model
class StatusListViewModel {
    
    lazy var statusList = [Status]()
    
    func loadStatus(completion: @escaping (_ isSuccess: Bool) -> ()) {
        NetworkManager.sharedManager.statusList { (list, success) in
            
            // 1. dictionary to array
            guard let array = NSArray.yy_modelArray(with: Status.self, json: list ?? []) as? [Status] else {
                
                completion(success)
                return
            }
            print(array)
            
            // 2. append data to statusList
            self.statusList.append(contentsOf: array)
            
            // 3. call back
            completion(success)
        }
    }
}
