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
    
    func loadStatus(pullup: Bool, completion: @escaping (_ isSuccess: Bool) -> ()) {
        
        // get since_id
        let since_id = pullup ? 0 : statusList.first?.id ?? 0
        let max_id = pullup ? statusList.last?.id ?? 0 : 0

        NetworkManager.sharedManager.statusList(since_id: since_id, max_id: max_id) { (list, success) in
            
            // 1. dictionary to array
            guard let array = NSArray.yy_modelArray(with: Status.self, json: list ?? []) as? [Status] else {
                
                completion(success)
                return
            }
            
            // 2. append data to statusList
            // if is pull up, append to end of statusList
            // otherwise, insert into begining of the statusList
            if pullup {
                self.statusList += array
            }else {
                self.statusList = array + self.statusList
            }
            
            // 3. call back
            completion(success)
        }
    }
}
