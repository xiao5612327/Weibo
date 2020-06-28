//
//  StatusViewModel.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/21/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

class StatusViewModel: CustomStringConvertible {
    
    var description: String {
        return status.description
    }
    
    var status: Status
    
    var memberIcon: UIImage?
    var vipIcon: UIImage?
    
    var retweetStr: String?
    var commentStr: String?
    var likeStr: String?
    
    var pictureViewSize = CGSize()
    
    var picURLs: [StatusPicture]? {
        return status.retweeted_status?.pic_urls ?? status.pic_urls
    }
    
    var retweetedText: String?
    
    init(status: Status) {
        self.status = status
        
        if status.user?.mbrank ?? 0 > 0 && status.user?.mbrank ?? 0 < 7 {
            let imageName = "common_icon_membership_level\(status.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
        
        switch status.user?.verified_type {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2, 3, 5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        retweetStr = getStr(count: status.reposts_count + 123400, defaultSTR: "retweet")
        commentStr = getStr(count: status.comments_count, defaultSTR: "comment")
        likeStr = getStr(count: status.attitudes_count, defaultSTR: "like")
        
        pictureViewSize = calcPictureViewSize(count: picURLs?.count)
        
        var str = "@" + (status.retweeted_status?.user?.screen_name ?? "") + ":"
            str = str + (status.retweeted_status?.text ?? "")
            
        retweetedText = str
    }
    
    
    private func calcPictureViewSize(count: Int?) -> CGSize {
        
        guard let count = count, count != 0 else {
            return .zero
        }
        
        let row: CGFloat = CGFloat((count - 1) / 3) + 1.0
        
        let height = StatusPictureViewOutterMargin + row * StatusPictureViewItemWidth + (row - 1) * StatusPictureViewInnerMargin
        
        return CGSize(width: StatusPictureViewWidth, height: height)
    }
    
    private func getStr(count: Int, defaultSTR: String) -> String {
        if count == 0 {
            return defaultSTR
        }
        
        if count < 1000 {
            return "\(count)"
        }
    
        return String(format: "%.02f k", CGFloat(count) / 1000.0)
    }
}
