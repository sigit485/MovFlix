//
//  MovieListPresenter.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol MovieListPresenterProtocol {
    func getListMovie(category: MovieCategory)
    func loadMoreMovies(category: MovieCategory)
    func getListMovieByGenre(idGenre: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    
    private let movieUseCase: MovieUseCase
    private let delegate: PresenterToViewProtocol?
    
    private var pagination: Int = 1
    public var listMovie: [MovieResponseResult] = []
    public var indexPaths: [IndexPath] = []
    
    init(movieUseCase: MovieUseCase, delegate: PresenterToViewProtocol?) {
        self.movieUseCase = movieUseCase
        self.delegate = delegate
    }
    
    func getListMovie(category: MovieCategory) {
        delegate?.showLoading()
        movieUseCase.getMovies(page: pagination, category: category) { result in
            switch result {
            case .success(let data):
                self.listMovie = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: NSObject())
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getListMovieByGenre(idGenre: Int) {
        delegate?.showLoading()
        movieUseCase.getMoviesByGenre(idGenre: idGenre, page: pagination) { result in
            switch result {
            case .success(let data):
                self.listMovie = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: NSObject())
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func loadMoreMoviesByGenre(idGenre: Int) {
        pagination += 1
        
        delegate?.showLoading()
        movieUseCase.getMoviesByGenre(idGenre: idGenre, page: pagination) { result in
            switch result {
            case .success(let data):
                let startIndex = self.listMovie.count - 1
                let endIndex = startIndex + data.count
                
                let tempIndexPaths = Array(startIndex..<endIndex).compactMap { return IndexPath(row: $0, section: 0) }
                self.indexPaths = tempIndexPaths
                
                self.listMovie.append(contentsOf: data)
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: NSObject())
            case .failure(let error):
                if self.pagination > 0 {
                    self.pagination -= 1
                }
                
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    
    func loadMoreMovies(category: MovieCategory) {
        pagination += 1
        
        delegate?.showLoading()
        movieUseCase.getMovies(page: pagination, category: category) { result in
            switch result {
            case .success(let data):
                let startIndex = self.listMovie.count - 1
                let endIndex = startIndex + data.count
                
                let tempIndexPaths = Array(startIndex..<endIndex).compactMap { return IndexPath(row: $0, section: 0) }
                self.indexPaths = tempIndexPaths
                
                self.listMovie.append(contentsOf: data)
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: NSObject())
            case .failure(let error):
                if self.pagination > 0 {
                    self.pagination -= 1
                }
                
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
}
