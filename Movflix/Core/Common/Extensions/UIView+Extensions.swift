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
}
