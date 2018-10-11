//
//  UIImage+Effect.swift
//  LOTs
//
//  Created by 乃方 on 2018/10/1.
//  Copyright © 2018年 Nia. All rights reserved.
//

import UIKit

extension UIView {
    
    func backgroundBorder() {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 1
//        self.layer.shouldRasterize = true
        self.layer.cornerRadius = 10
        
    }
    
    func backgroundBord() {
        
        self.layer.borderColor = #colorLiteral(red: 0.8901960784, green: 0.8901960784, blue: 0.8901960784, alpha: 1)
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
        
    }
    
    func corner(corner: CGFloat = 6) {
        
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
        
    }
    
    func titleShadow(color: UIColor = .black) {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize.zero
        self.layer.masksToBounds = false
        
    }
    
    func roundCorner() {
        
        self.layer.cornerRadius = (self.frame.width) / 2
        self.layer.masksToBounds = true
        
    }
    
    func cornerBorder() {
        
        self.layer.cornerRadius = (self.frame.width) / 2
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
    }
    
}

