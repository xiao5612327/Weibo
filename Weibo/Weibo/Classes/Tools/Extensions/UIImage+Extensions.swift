//
//  UIImage+Extensions.swift
//  Weibo
//
//  Created by Xiaoping Weng on 6/22/20.
//  Copyright © 2020 Xiaoping Weng. All rights reserved.
//

import Foundation

extension UIImage {
    
    func cz_image(size: CGSize?, backColor: UIColor = UIColor.white, line: UIColor = .darkGray) -> UIImage? {
        var size = size
        
        if size == nil {
            size = self.size
        }
        
        let rect = CGRect(origin: .zero, size: size!)
        UIGraphicsBeginImageContextWithOptions(size!, true, 1.0)
        
        backColor.setFill()
        UIRectFill(rect)
        
        let path = UIBezierPath(ovalIn: rect)
        path.addClip()
        
        draw(in: rect)
        
        let ovalPath = UIBezierPath(ovalIn: rect)

        line.setStroke()
        ovalPath.stroke()
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return result
        
    }
}
