//
//  UIActivity+Extensions.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit

extension UIActivityIndicatorView {
    public func startActivityIndicator(from viewController: UIViewController){
        self.center = viewController.view.center
        self.hidesWhenStopped = true
        self.color = .darkGray
        viewController.view.addSubview(self)
        self.startAnimating()
    }
}
