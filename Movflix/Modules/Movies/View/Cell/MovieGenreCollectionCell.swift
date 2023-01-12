//
//  MovieGenreCollectionCell.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit


class MovieGenreCollectionCell: UICollectionViewCell, ContentCellProtocol {
    public static let identifier = "MovieGenreCollectionCell"
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.shared.redPrimary.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let genreTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        contentView.addSubview(backdropImageView)
        backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backdropImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(transparentView)
        transparentView.leadingAnchor.constraint(equalTo: backdropImageView.leadingAnchor).isActive = true
        transparentView.trailingAnchor.constraint(equalTo: backdropImageView.trailingAnchor).isActive = true
        transparentView.topAnchor.constraint(equalTo: backdropImageView.topAnchor).isActive = true
        transparentView.bottomAnchor.constraint(equalTo: backdropImageView.bottomAnchor).isActive = true
        
        contentView.addSubview(genreTitleLabel)
        genreTitleLabel.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor).isActive = true
        genreTitleLabel.trailingAnchor.constraint(equalTo: transparentView.trailingAnchor).isActive = true
        genreTitleLabel.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor).isActive = true
        genreTitleLabel.topAnchor.constraint(equalTo: transparentView.topAnchor).isActive = true
    }
    
    func configure<T>(object: T?) {
        if let object = object as? GenreResult {
            genreTitleLabel.text = object.name ?? ""
            backdropImageView.image = UIImage(named: object.name ?? "")
        }
    }

}
