//
//  WelcomeView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/20/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class NewFeatureView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBAction func enterStatus(_ sender: Any) {
        
    }
    
    class func newFeatureView() -> NewFeatureView {
        let nib = UINib(nibName: "NewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! NewFeatureView
        
        // from xib load view default is 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }

    override func awakeFromNib() {
        print(bounds)
        let count = 4
        let rect = UIScreen.main.bounds
        for i in 0..<count {
            let imageName = "new_feature_\(i + 1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            scrollView.addSubview(iv)
        }
        
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        enterButton.isHidden = true
    }
}
