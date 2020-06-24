//
//  StatusPictureView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/23/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class StatusPictureView: UIView {

    var urls: [StatusPicture]? {
        didSet {
            for v in subviews {
                v.isHidden = true
            }
            
            var index = 0
            for url in urls ?? [] {
                
                if urls?.count == 4 && index == 1 {
                    index += 1
                    continue
                }
                
                let iv = subviews[index] as! UIImageView
                iv.cz_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)
                iv.isHidden = false

                index += 1

            }
        }
    }
    
    @IBOutlet weak var heightCons: NSLayoutConstraint!
 
    override func awakeFromNib() {
        setupUI()
    }
}


extension StatusPictureView {
    
    private func setupUI() {
        backgroundColor = superview?.backgroundColor
        
        clipsToBounds = true
        
        let count = 9
        
        let rect = CGRect(x: 0, y: 0, width: StatusPictureViewItemWidth, height: StatusPictureViewItemWidth)
        
        for i in 0..<count * count {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            
            let row = CGFloat(i / count)
            let col = CGFloat(i % count)
            
            let xOffSet = col * (StatusPictureViewItemWidth + StatusPictureViewInnerMargin)
            let yOffSet = row * (StatusPictureViewItemWidth + StatusPictureViewInnerMargin)
            iv.frame = rect.offsetBy(dx: xOffSet, dy: yOffSet)
            addSubview(iv)
        }
    }
}
