//
//  MoviePresenter.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

protocol MoviePresenterProtocol {
    func getGenreList()
    func getNowPlaying(page: Int)
    func getTopRated(page: Int)
    func getPopular(page: Int)
}

class MoviePresenter: MoviePresenterProtocol {
    private let movieUseCase: MovieUseCase
    private let delegate: PresenterToViewProtocol?
    
    public var genreList: [GenreResult] = []
    
    public var nowPlaying: [MovieResponseResult] = []
    public var topRated: [MovieResponseResult] = []
    public var popular: [MovieResponseResult] = []
    
    init(movieUseCase: MovieUseCase, delegate: PresenterToViewProtocol) {
        self.movieUseCase = movieUseCase
        self.delegate = delegate
    }
    
    func getGenreList() {
        delegate?.showLoading()
        movieUseCase.getMovieGenreList { result in
            switch result {
            case .success(let data):
                let category: MovieCategory = .genre
                self.genreList = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: category)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getNowPlaying(page: Int) {
        let category = MovieCategory.nowPlaying

        delegate?.showLoading()
        movieUseCase.getMovies(page: page, category: category) { result in
            switch result {
            case .success(let data):
                self.nowPlaying = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: category)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getTopRated(page: Int) {
        let category = MovieCategory.topRated

        delegate?.showLoading()
        movieUseCase.getMovies(page: page, category: category) { result in
            switch result {
            case .success(let data):
                self.topRated = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: category)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getPopular(page: Int) {
        let category = MovieCategory.popular

        delegate?.showLoading()
        movieUseCase.getMovies(page: page, category: category) { result in
            switch result {
            case .success(let data):
                self.popular = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: category)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
}
