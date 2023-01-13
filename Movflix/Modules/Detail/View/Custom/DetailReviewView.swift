//
//  DetailReviewView.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import UIKit
import Cosmos
import Kingfisher

class DetailReviewView: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = "mooney240"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home_ic_cinema")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return image
    }()
    
    private let reviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.shared.textPlaceholder
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 8
        label.text = "**Avatar: The Way of Water follows in its predecessor’s footsteps with stunning effects and a mediocre story.** It’s a James Cameron film, so it’s impressive. The special effects, camerawork, world-building, and action were all off the charts. But Avatar: The Way of Water struggles like its predecessor in the story and character development departments. In fact, the story of The Way of Water is almost identical to the first Avatar. Instead of humans learning to be Na’vi and then fighting Stephen slang, a family of forest Na’vi learns to be ocean Na’vi and then fight Stephen Lang. But the new movie also focuses on a group of annoying teens that constantly get themselves in trouble and peril over and over again throughout the much too long 3+ hour runtime and sidelining better, more established characters. All the strengths and weaknesses of the first movie are back in this one, with the bonus of being compared to the original at every turn. It really is a visual feast and special effects masterpiece, but just like the first Avatar, that’s all it is."
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(hStackRating)
        stack.addArrangedSubview(reviewLabel)
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        addSubview(avatarImageView)
        avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        
        addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        
        addSubview(vStackContent)
        vStackContent.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        vStackContent.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        vStackContent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        vStackContent.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
    }
    
    func setup(review: DetailReviewResult) {
        nameLabel.text = review.author ?? "-"
        avatarImageView.kf.setImage(with: URL.imagePath(from: review.authorDetails?.avatarPath ?? ""), placeholder: UIImage(named: "home_ic_cinema"))
        reviewLabel.text = review.content ?? ""
        ratingLabel.text = String(review.authorDetails?.rating ?? 0.0)
        
        if let rating = review.authorDetails?.rating {
            ratingView.rating = rating / 2
        } else {
            hStackRating.isHidden = true
        }
    }
    
}
