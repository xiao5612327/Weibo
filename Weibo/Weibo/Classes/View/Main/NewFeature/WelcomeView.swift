//
//  WelcomeView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/20/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class WelcomeView: UIView {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    
    class func welcomeView() -> WelcomeView {
        let nib = UINib(nibName: "WelcomeView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WelcomeView
        
        // from xib load view default is 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func awakeFromNib() {
        print(NetworkManager.sharedManager.userAccount.avatar_large)
//        guard let urlString = NetworkManager.sharedManager.userAccount.avatar_large, let url = URL(string: urlString) else {
//            return
//        }
//
        
        iconImage.layer.masksToBounds = true
        iconImage.layer.cornerRadius = iconImage.bounds.height / 2
    }
//    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        self.layoutIfNeeded()
        
        bottomCons.constant = bounds.height - 200
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            
            self.layoutIfNeeded()
        }, completion: {( _ ) in
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.tipLabel.alpha = 1
            }, completion: { ( _ ) in
                self.removeFromSuperview()
            })
        })
    }
}
