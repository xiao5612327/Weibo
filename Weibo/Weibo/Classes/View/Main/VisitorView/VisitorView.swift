//
//  VisitorView.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/16/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

/// visitor view
class VisitorView: UIView {

    var visitorInfo: [String: String]? {
        didSet {
            // 1. get dict info
            guard let imageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                return
            }
            
            tipLabel.text = message
            
            // home page no need set icon image
            if imageName.isEmpty {
                startAnimation()
                return
            }
            
            iconView.image = UIImage(named: imageName)
            
            // house icon view only for home page. so hide for other tabbar items
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    
    // MARK: initialize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // rotating icon animation
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * CGFloat.pi
        anim.duration = 15
        anim.repeatCount = MAXFLOAT
        // usually used for cycling image rotation animation.
        anim.isRemovedOnCompletion = false
        
        // add animation to icon view
        iconView.layer.add(anim, forKey: nil)
    }
    
    // MARK: - private properties
    private lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    
    private lazy var maskIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    
    private lazy var houseIconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    
    private lazy var tipLabel: UILabel = UILabel.cz_label(
        withText: "Follow some people, back to here find out what is surpise, back to here to see what is happening!",
        fontSize: 14,
        color: .darkGray)

    private lazy var registerButton: UIButton = UIButton.cz_textButton(
        "Register",
        fontSize: 16,
        normalColor: .orange,
        highlightedColor: .black,
        backgroundImageName: "common_button_white_disable")
    
    private lazy var loginButton: UIButton = UIButton.cz_textButton(
        "Log in",
        fontSize: 16,
        normalColor: .black,
        highlightedColor: .black,
        backgroundImageName: "common_button_white_disable")

}

// MARK: - set up all ui
extension VisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // 1. add Views
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        tipLabel.textAlignment = .center
        // 2. programmiclly set up autolayout
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let margin: CGFloat = 20
        // icon view
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1,
            constant: 0))
        
        addConstraint(NSLayoutConstraint(
            item: iconView,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1,
            constant: -60))
        
        // house icon view
        addConstraint(NSLayoutConstraint(
                  item: houseIconView,
                  attribute: .centerX,
                  relatedBy: .equal,
                  toItem: iconView,
                  attribute: .centerX,
                  multiplier: 1,
                  constant: 0))
              
              addConstraint(NSLayoutConstraint(
                  item: houseIconView,
                  attribute: .centerY,
                  relatedBy: .equal,
                  toItem: iconView,
                  attribute: .centerY,
                  multiplier: 1,
                  constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1,
                                         constant: margin))
        
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 236))
        
        // 4. register button
        registerButton.leftAnchor.constraint(equalTo: tipLabel.leftAnchor).isActive = true
        registerButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        registerButton.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: margin).isActive = true
        
        // 5. login button
        loginButton.rightAnchor.constraint(equalTo: tipLabel.rightAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        loginButton.topAnchor.constraint(equalTo: tipLabel.bottomAnchor, constant: margin).isActive = true
        
        let viewDict = ["maskIconView" : maskIconView,
                        "registerButton": registerButton]
        
        let metrics = ["spacing": -20 ]
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[maskIconView]-0-|",
            options: [],
            metrics: nil,
            views: viewDict))
        
        addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]",
            options: [],
            metrics: metrics,
            views: viewDict))
    }
}
