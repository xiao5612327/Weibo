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
    }
}
