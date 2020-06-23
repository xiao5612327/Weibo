//
//  StatusCellTableViewCell.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/21/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import UIKit

class StatusCellTableViewCell: UITableViewCell {

    var viewModel: StatusViewModel? {
        didSet {
            
            fullTextLabel.text = viewModel?.status.text
            name.text = viewModel?.status.user?.screen_name
            
            vipImageView.image = viewModel?.memberIcon
            avatar.image = viewModel?.vipIcon
            
            profileImageView.cz_setImage(urlString: viewModel?.status.user?.profile_image_url, placeholderImage: UIImage(named: "avatar_default_big"), isAvatar: true)
            
        }
    }
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var avatar: UIImageView!

    @IBOutlet weak var fullTextLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
