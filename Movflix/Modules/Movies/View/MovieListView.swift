//
//  MovieListView.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit
import UIScrollView_InfiniteScroll

class MovieListView: BaseView {
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    public var presenter: MovieListPresenter?
    public var router: MovieRouter?
    
    public var category: MovieCategory = .nowPlaying
    public var idGenre: Int?
    
    private let activityIndicator = UIActivityIndicatorView()
    private var isLoadMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureConstraint()
        initInfiniteScroll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.title = category.description
        fetchData()
    }
    
    private func configureConstraint() {
        view.addSubview(movieTableView)
        movieTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func fetchData() {
        DispatchQueue.global().async {
            if let idGenre = self.idGenre {
                self.presenter?.getListMovieByGenre(idGenre: idGenre)
            } else {
                self.presenter?.getListMovie(category: self.category)
            }
        }
    }
    
    private func initInfiniteScroll() {
        movieTableView.infiniteScrollDirection = .vertical
        movieTableView.addInfiniteScroll { tableView in
            DispatchQueue.global().async {
                self.isLoadMore = true
                if let idGenre = self.idGenre {
                    self.presenter?.loadMoreMoviesByGenre(idGenre: idGenre)
                } else {
                    self.presenter?.loadMoreMovies(category: self.category)
                }
            }
        }
    }
    
}

extension MovieListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.listMovie.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        if let movies = presenter?.listMovie[indexPath.row] {
            cell.configure(object: movies)
        }
        return cell
    }
    
    
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let idMovie = presenter?.listMovie[indexPath.row].id else { return }
        router?.pushToDetail(from: self, idMovie: idMovie)
    }
}

extension MovieListView: PresenterToViewProtocol {
    func successLoadData<T>(object: T?) {
        DispatchQueue.main.async {
            if self.isLoadMore {
                self.isLoadMore = false
                self.movieTableView.finishInfiniteScroll()
                guard let indexPaths = self.presenter?.indexPaths else { return }
                self.movieTableView.beginUpdates()
                self.movieTableView.insertRows(at: indexPaths, with: .fade)
                self.movieTableView.endUpdates()
            } else {
                self.movieTableView.reloadData()
            }
            
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            if !self.isLoadMore {
                self.activityIndicator.startActivityIndicator(from: self)
            }
        }
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            if !self.isLoadMore {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func failedLoadData(Error: Error) {
        
    }
}
