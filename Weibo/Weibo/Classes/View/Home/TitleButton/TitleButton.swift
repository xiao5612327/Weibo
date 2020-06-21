//
//  TitleButton.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/19/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    init(title: String?) {
        super.init(frame: CGRect())
        
        if title == nil {
            setTitle("Home", for: .normal)
        }else {
            setTitle(title!, for: .normal)
            
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .normal)
            setImage(UIImage(named: "navigationbar_arrow_up"), for: .selected)
        }
        
        titleLabel?.font = .boldSystemFont(ofSize: 17)
        setTitleColor(.darkGray, for: .normal)
        
        sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel, let imageView = imageView else {
            return
        }
        
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
    }
    
}
