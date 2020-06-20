//
//  WelcomeView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/20/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class WelcomeView: UIView {

    class func welcomeView() -> WelcomeView {
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WelcomeView
        
        // from xib load view default is 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
}
