//
//  DetailPresenter.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol DetailPresenterProtocol {
    func getDetailMovie(idMovie: Int)
    func getVideosMovie(idMovie: Int)
    func getReviewsMovie(idMovie: Int)
}

protocol DetailTVPresenterProtocol {
    func getDetailTV(idTV: Int)
}

class DetailPresenter: DetailPresenterProtocol {
    private let detailUseCase: DetailUseCase
    private let delegate: PresenterToViewProtocol?
    
    public var youtubeKey: String?
    public var reviews: [DetailReviewResult] = []
        
    init(useCase: DetailUseCase, delegate: PresenterToViewProtocol) {
        self.detailUseCase = useCase
        self.delegate = delegate
    }
    
    
    func getDetailMovie(idMovie: Int) {
        delegate?.showLoading()
        detailUseCase.getDetailMovie(idMovie: idMovie) { result in
            switch result {
            case .success(let data):
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: data)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getVideosMovie(idMovie: Int) {
        delegate?.showLoading()
        detailUseCase.getVideosMovie(idMovie: idMovie) { result in
            switch result {
            case .success(let data):
                self.youtubeKey = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: data)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getReviewsMovie(idMovie: Int) {
        delegate?.showLoading()
        detailUseCase.getReviewsMovie(idMovie: idMovie) { result in
            switch result {
            case .success(let data):
                self.reviews = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: data)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
}


extension DetailPresenter: DetailTVPresenterProtocol {
    func getDetailTV(idTV: Int) {
        delegate?.showLoading()
        detailUseCase.getDetailTV(idTV: idTV) { result in
            switch result {
            case .success(let data):
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: data)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
}
