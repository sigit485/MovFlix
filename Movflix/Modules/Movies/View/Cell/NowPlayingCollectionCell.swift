//
//  NowPlayingCollectionCell.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit
import Kingfisher

class NowPlayingCollectionCell: UICollectionViewCell {
    
    public static let identifier = "NowPlayingCollectionCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func commonInit() {
        contentView.addSubview(posterImageView)
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        posterImageView.setCornerRadius(corner: 5)
    }
    
    func configure<T>(object: T?) {
        if let object = object as? MovieResponseResult {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL.imagePath(from: object.posterPath ?? ""))
        } else if let object = object as? TVResponseResult {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL.imagePath(from: object.posterPath ?? ""))
        }
        
    }
    
}
