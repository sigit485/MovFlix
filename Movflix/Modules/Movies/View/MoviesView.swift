//
//  HomeView.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MoviesView: BaseView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(hStackGenre)
        stackView.addArrangedSubview(genreCollection)
        stackView.addArrangedSubview(hStackNowPlaying)
        stackView.addArrangedSubview(nowPlayingCollection)
        stackView.addArrangedSubview(hStackTopRated)
        stackView.addArrangedSubview(topRatedCollection)
        stackView.addArrangedSubview(vStackPopular)
        stackView.addArrangedSubview(bannerPopularView)
        return stackView
    }()
    
    // MARK: Genre List
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = MoviesConstant.genreTitle
        return label
    }()
    
    private lazy var hStackGenre: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        stack.addArrangedSubview(genreLabel)
        return stack
    }()
    
    private lazy var genreCollection: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionFlowLayout.itemSize = CGSize(width: 130, height: 70)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            MovieGenreCollectionCell.self,
            forCellWithReuseIdentifier: MovieGenreCollectionCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        return collectionView
    }()
    
    // MARK: Now Playing
    private let nowPlayingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = MoviesConstant.nowTitle
        return label
    }()
    
    private lazy var seeNowPlayingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = Constant.seeAllTitle
        label.textColor = Color.shared.redPrimary
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTapped(sender:)))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var nowPlayingCollection: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionFlowLayout.itemSize = CGSize(width: 110, height: 160)
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            NowPlayingCollectionCell.self,
            forCellWithReuseIdentifier: NowPlayingCollectionCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return collectionView
    }()
    
    private lazy var hStackNowPlaying: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        stack.addArrangedSubview(nowPlayingLabel)
        stack.addArrangedSubview(seeNowPlayingLabel)
        return stack
    }()
    
    
    // MARK: Top Rated
    private let topRatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = MoviesConstant.topTitle
        return label
    }()
    
    private lazy var seeTopRatedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = Constant.seeAllTitle
        label.textColor = Color.shared.redPrimary
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTapped(sender:)))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var topRatedCollection: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionFlowLayout.itemSize = CGSize(width: 110, height: 160)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NowPlayingCollectionCell.self, forCellWithReuseIdentifier: NowPlayingCollectionCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return collectionView
    }()
    
    private lazy var hStackTopRated: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        stack.addArrangedSubview(topRatedLabel)
        stack.addArrangedSubview(seeTopRatedLabel)
        return stack
    }()
    
    // MARK: Popular
    private lazy var bannerPopularView: MovieBannerGradientView = {
        let view = MovieBannerGradientView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        view.addSubview(popularImageView)
        popularImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        popularImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        popularImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        popularImageView.widthAnchor.constraint(equalToConstant: 190).isActive = true
        
        view.addSubview(popularCollection)
        popularCollection.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        popularCollection.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        popularCollection.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        return view
    }()
    
    private let popularImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "home_ic_cinema")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var popularCollection: UICollectionView = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 16)
        collectionFlowLayout.itemSize = CGSize(width: 110, height: 160)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            NowPlayingCollectionCell.self,
            forCellWithReuseIdentifier: NowPlayingCollectionCell.identifier)
        collectionView.collectionViewLayout = collectionFlowLayout
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        return collectionView
    }()
    
    private let popularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = MoviesConstant.popularTitle
        return label
    }()
    
    private lazy var seePopularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = Constant.seeAllTitle
        label.textColor = Color.shared.redPrimary
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationTapped(sender:)))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private lazy var vStackPopular: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        stack.addArrangedSubview(popularLabel)
        stack.addArrangedSubview(seePopularLabel)
        return stack
    }()
    
    private let refreshControl = UIRefreshControl()
    
    public var presenter: MoviePresenter?
    public var router: MovieRouter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createNavBar(image: UIImage(named: "splash")!)
        configureConstraint()
        setupRefreshControl()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        scrollView.addSubview(refreshControl)
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
    
    @objc private func fetchData() {
        DispatchQueue.global().async {
            self.presenter?.getGenreList()
            self.presenter?.getNowPlaying(page: 1)
            self.presenter?.getTopRated(page: 1)
            self.presenter?.getPopular(page: 1)
        }
    }
    
    @objc private func navigationTapped(sender: UITapGestureRecognizer) {
        switch sender.view {
        case seeNowPlayingLabel:
            router?.pushToList(from: self, category: .nowPlaying)
        case seeTopRatedLabel:
            router?.pushToList(from: self, category: .topRated)
        case seePopularLabel:
            router?.pushToList(from: self, category: .popular)
        default:
            break
        }
    }
    
}

extension MoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case genreCollection:
            if presenter?.genreList.count ?? 0 > 7 {
                return 7
            } else {
                return presenter?.genreList.count ?? 0
            }
        case nowPlayingCollection:
            return presenter?.nowPlaying.count ?? 0
        case topRatedCollection:
            return presenter?.topRated.count ?? 0
        case popularCollection:
            return presenter?.popular.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case genreCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieGenreCollectionCell.identifier, for: indexPath) as! MovieGenreCollectionCell
            if let genre = presenter?.genreList[indexPath.row] {
                cell.configure(object: genre)
            }
            cell.setCornerRadius(corner: 5)
            return cell
        case nowPlayingCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionCell.identifier, for: indexPath) as! NowPlayingCollectionCell
            if let movie = presenter?.nowPlaying[indexPath.row] {
                cell.configure(object: movie)
            }
            return cell
        case topRatedCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionCell.identifier, for: indexPath) as! NowPlayingCollectionCell
            if let movie = presenter?.topRated[indexPath.row] {
                cell.configure(object: movie)
            }
            return cell
        case popularCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCollectionCell.identifier, for: indexPath) as! NowPlayingCollectionCell
            if let movie = presenter?.popular[indexPath.row] {
                cell.configure(object: movie)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension MoviesView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case genreCollection:
            guard let idGenre = presenter?.genreList[indexPath.row].id else { return }
            router?.pushGenreToList(from: self, idGenre: idGenre)
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == popularCollection {
            let index = scrollView.contentOffset.x / 160
            let inn = 1.0 - index
            popularImageView.alpha = inn
        }
    }
}

extension MoviesView: PresenterToViewProtocol {
    func successLoadData<T>(object: T?) {
        guard let categoryData = object as? MovieCategory else { return }
        DispatchQueue.main.async {
            switch categoryData {
            case .nowPlaying:
                self.nowPlayingCollection.reloadData()
            case .topRated:
                self.topRatedCollection.reloadData()
            case .popular:
                self.popularCollection.reloadData()
            case .genre:
                self.genreCollection.reloadData()
            default:
                break
            }
        }
    }
    
    func showLoading() {
        
    }
    
    func dismissLoading() {
        refreshControl.endRefreshing()
    }
    
    func failedLoadData(Error: Error) {
        
    }
}
