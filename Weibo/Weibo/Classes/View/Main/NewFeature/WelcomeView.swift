//
//  WelcomeView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/20/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    
    class func welcomeView() -> WelcomeView {
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WelcomeView
        
        // from xib load view default is 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.height - 200
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
            self.layoutIfNeeded()
        }, completion: {( _ ) in
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.tipLabel.alpha = 1
            }, completion: nil)
        })
        
       
    }
}
