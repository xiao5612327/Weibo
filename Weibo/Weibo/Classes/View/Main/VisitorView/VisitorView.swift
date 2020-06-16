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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private properties
    private lazy var iconView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
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
        normalColor: .orange,
        highlightedColor: .black,
        backgroundImageName: "common_button_white_disable")

}

// MARK: - set up all ui
extension VisitorView {
    
    func setupUI() {
        backgroundColor = .white
        
        // 1. add Views
        addSubview(iconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
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
    }
}
