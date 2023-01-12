//
//  MovieTableViewCell.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit
import Kingfisher
import Cosmos

class MovieTableViewCell: UITableViewCell, ContentCellProtocol {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = Color.shared.textPlaceholder
        return label
    }()
    
    private let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .orange
        return label
    }()
    
    private let ratingView: CosmosView = {
        let rating = CosmosView(frame: CGRect.zero)
        rating.settings.updateOnTouch = false
        rating.settings.fillMode = .full
        rating.settings.starSize = 20
        rating.settings.starMargin = 0
        rating.settings.filledColor = .orange
        rating.settings.emptyColor = .lightGray
        rating.settings.emptyBorderColor = .clear
        rating.settings.filledBorderColor = .clear
        return rating
    }()
    
    lazy var vStackLabel : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 12, bottom: 12, right: 12)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(ratingView)
        stack.addArrangedSubview(voteLabel)
        return stack
    }()

    static let identifier = "MovieTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        contentView.addSubview(posterImageView)
        posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        posterImageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        posterImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(vStackLabel)
        vStackLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor).isActive = true
        vStackLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStackLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor).isActive = true
        
        posterImageView.setCornerRadius(corner: 5)
    }

    
    func configure<T>(object: T?) {
        if let object = object as? MovieResponseResult {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL.imagePath(from: object.posterPath ?? ""), placeholder: UIImage(named: "home_ic_cinema"))
            titleLabel.text = object.title ?? ""
            dateLabel.text = object.releaseDate ?? ""
            ratingView.rating = (object.voteAverage ?? 0.0) / 2
            voteLabel.text = "\(object.voteAverage ?? 0) Vote"
        } else if let object = object as? TVResponseResult {
            posterImageView.kf.indicatorType = .activity
            posterImageView.kf.setImage(with: URL.imagePath(from: object.posterPath ?? ""), placeholder: UIImage(named: "home_ic_script"))
            titleLabel.text = object.name ?? ""
            dateLabel.text = object.firstAirDate ?? ""
            ratingView.rating = (object.voteAverage ?? 0.0) / 2
            voteLabel.text = "\(object.voteAverage ?? 0) Vote"
        }
    }
}
