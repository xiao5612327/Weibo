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
        removeFromSuperview()
    }
    
    class func newFeatureView() -> NewFeatureView {
        let nib = UINib(nibName: "NewFeatureView", bundle: nil)
        
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! NewFeatureView
        
        // from xib load view default is 600 * 600
        v.frame = UIScreen.main.bounds
        
        return v
    }

    override func awakeFromNib() {
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
        scrollView.delegate = self
    }
}

extension NewFeatureView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 1. scroll to last page
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if index == scrollView.subviews.count {
            self.removeFromSuperview()
        }
        
        enterButton.isHidden = !(index == scrollView.subviews.count - 1)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        enterButton.isHidden = true
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width + 0.5)
        
        pageControl.currentPage = page
        pageControl.isHidden = (page == scrollView.subviews.count)
    }
}
