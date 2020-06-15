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
    convenience init(title: String, fontSize: CGFloat = 16, target: AnyObject?, action: Selector) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fontSize, normalColor: .darkGray, highlightedColor: .orange)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        self.init(customView: btn)
        
    }
}
