//
//  UIImageView+SDWebImage.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/22/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    func cz_setImage(urlString: String?, placeholderImage: UIImage?, isAvatar: Bool = false) {
        
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = placeholderImage
            return
        }

        sd_setImage(with: url, placeholderImage: placeholderImage, options: []) { [weak self] (image, _, _, _) in
            
            if isAvatar {
                self?.image = image?.cz_image(size: self?.bounds.size)
            }
        }
    }
}
