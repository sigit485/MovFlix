//
//  HomeBannerGradientView.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MovieBannerGradientView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private lazy var gradientLayer: CAGradientLayer = {
        let l = CAGradientLayer()
        l.frame = self.bounds
        l.colors = [Color.shared.redPrimary.cgColor, UIColor.white.cgColor]
        l.startPoint = CGPoint(x: 0, y: 0.5)
        l.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(l, at: 0)
        return l
    }()
}
