//
//  DetailView.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit
import Cosmos
import Kingfisher

class DetailView: BaseView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(backdropImageView)
        stackView.addArrangedSubview(buttonPlay)
        stackView.addArrangedSubview(hStackHead)
        stackView.addArrangedSubview(vStackOverview)
        return stackView
    }()
    
    private let backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return imageView
    }()
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        imageView.setCornerRadius(corner: 5)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.shared.textPlaceholder
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return label
    }()
    
    private let voteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.shared.textPlaceholder
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let overviewTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Overview"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.shared.textPlaceholder
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    lazy var vStackOverview : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        stack.addArrangedSubview(overviewTitleLabel)
        stack.addArrangedSubview(overviewLabel)
        return stack
    }()
    
    private lazy var buttonPlay: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Color.shared.redPrimary
        btn.setTitle("  Watch Trailer/Preview", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        let image = UIImage(named: "detail_ic_play")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: .normal)
        btn.tintColor = .white
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        btn.addTarget(self, action: #selector(openYoutube(sender:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var vStackContent: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 6
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(dateLabel)
        stack.addArrangedSubview(voteLabel)
        stack.addArrangedSubview(hStackRating)
        return stack
    }()
    
    private lazy var hStackHead: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16)
        stack.addArrangedSubview(posterImageView)
        stack.addArrangedSubview(vStackContent)
        return stack
    }()
    
    lazy var hStackRating: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .top
        stack.addArrangedSubview(ratingView)
        return stack
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
    
    private let activityIndicator = UIActivityIndicatorView()
    
    public var presenter: DetailPresenter?
    public var idMovie: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraint()
        fetchData()
    }
    
    private func configureConstraint() {
        view.addSubview(scrollView)
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        scrollView.addSubview(containerStackView)
        containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    }
    
    private func fetchData() {
        guard let idMovie = self.idMovie else { return }
        DispatchQueue.global().async {
            self.presenter?.getDetailMovie(idMovie: idMovie)
            self.presenter?.getVideosMovie(idMovie: idMovie)
        }
    }
    
    private func setupBindingData(movie: DetailMovieResponseEntity) {
        scrollView.isHidden = false
        
        titleLabel.text = movie.title ?? ""
        navigationItem.title = movie.title ?? ""
        dateLabel.text = "Release: \(movie.releaseDate ?? "-")"
        voteLabel.text = "Vote: \(movie.voteAverage ?? 0.0)"
        ratingView.rating = ((movie.voteAverage ?? 0) / 2)
        overviewLabel.text = movie.overview ?? ""
        
        posterImageView.kf.setImage(
            with: URL.imagePath(from: movie.posterPath ?? ""),
            placeholder: UIImage(named: "home_ic_cinema"))
        
        if let backdropPath = movie.backdropPath, !backdropPath.isEmpty {
            backdropImageView.kf.indicatorType = .activity
            backdropImageView.kf.setImage(
                with: URL.imageLargePath(from: backdropPath))
        } else {
            backdropImageView.isHidden = true
        }
    }
    
    @objc private func openYoutube(sender: UIButton) {
        guard let youtubeId = presenter?.youtubeKey, !youtubeId.isEmpty else { return }
        if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
           UIApplication.shared.canOpenURL(youtubeURL) {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
}

extension DetailView: PresenterToViewProtocol {
    func successLoadData<T>(object: T?) {
        DispatchQueue.main.async {
            if let object = object as? DetailMovieResponseEntity {
                self.setupBindingData(movie: object)
            } else if let _ = object as? String {
                if self.presenter?.youtubeKey == nil || self.presenter?.youtubeKey?.isEmpty == true {
                    self.buttonPlay.isHidden = true
                }
            }
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startActivityIndicator(from: self)
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func failedLoadData(Error: Error) {
        
    }
}
