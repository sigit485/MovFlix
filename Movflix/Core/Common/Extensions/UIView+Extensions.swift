//
//  UIView+Extensions.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

extension UIView {
    func setCornerRadius(corner: CGFloat) {
        self.layer.cornerRadius = corner
        self.clipsToBounds = true
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
    }
}
