//
//  UIBarButtonItem+Extensions.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/15/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    
    /// Create custom UIBarButton
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: font size, default 16
    ///   - target: target
    ///   - action: action method
    ///   - isBackButton: check barButton is back, if it is true, add back arrow image
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector, isBackButton: Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: .darkGray, highlightedColor: .orange)
        if isBackButton {
            let imageName = "navigationbar_back_withtext"
            btn.setImage(UIImage(named: imageName), for: .normal)
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
            btn.sizeToFit()
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
        
    }
}
