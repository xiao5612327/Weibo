//
//  UIViewController+Extensions.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/15/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

extension UIViewController {
    var topStatusBarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height
    }
    
    var bottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
}
