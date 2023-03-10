//
//  BaseView.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

enum MovieCategory {
    case nowPlaying
    case topRated
    case popular
    case genre
    case discover
    
    var description: String {
        switch self {
        case .nowPlaying:
            return "Now Playing"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        case .genre:
            return "Genre"
        case .discover:
            return "Discover"
        }
    }
    
}

enum TVCategory {
    case onAir
    case topRated
    case popular
    
    var description: String {
        switch self {
        case .onAir:
            return "On The Air"
        case .topRated:
            return "Top Rated"
        case .popular:
            return "Popular"
        }
    }
}

class BaseView: UIViewController {
    
    func createNavBar(title: String? = nil, image: UIImage) {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.text = title ?? ""
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .systemBlue
        
        let hStack = UIStackView()
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.addArrangedSubview(imageView)
        hStack.addArrangedSubview(titleLabel)
        
        let leftBarButton = UIBarButtonItem(customView: hStack)
        navigationItem.setLeftBarButton(leftBarButton, animated: true)
    }
    
    func showAlert(title: String? = "", message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        })
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
    
}
