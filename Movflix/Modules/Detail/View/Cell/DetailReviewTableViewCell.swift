//
//  ReviewTableViewCell.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import UIKit
import Cosmos
import Kingfisher

class DetailReviewTableViewCell: UITableViewCell, ContentCellProtocol {
    static let identifier = "DetailReviewTableViewCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.shared.textPlaceholder
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
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
        rating.rating = 0
        return rating
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.text = "10.0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var hStackRating: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.addArrangedSubview(ratingView)
        stack.addArrangedSubview(ratingLabel)
        return stack
    }()
    
    private lazy var vStackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 8
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(hStackRating)
        stack.addArrangedSubview(reviewLabel)
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        selectionStyle = .none
        
        contentView.addSubview(avatarImageView)
        avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        
        contentView.addSubview(vStackContent)
        vStackContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        vStackContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        vStackContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        vStackContent.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    func configure<T>(object: T?) {
        if let object = object as? DetailReviewResult {
            nameLabel.text = object.author ?? "-"
            avatarImageView.kf.setImage(with: URL.imagePath(from: object.authorDetails?.avatarPath ?? ""),
                                        placeholder: UIImage(named: "home_ic_cinema"))
            reviewLabel.text = object.content ?? ""
            ratingLabel.text = String(object.authorDetails?.rating ?? 0.0)
            if let rating = object.authorDetails?.rating {
                ratingView.rating = rating / 2
            } else {
                hStackRating.isHidden = true
            }
        }
    }
}
