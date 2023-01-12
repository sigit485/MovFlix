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
}

class DetailPresenter: DetailPresenterProtocol {
    private let detailUseCase: DetailUseCase
    private let delegate: PresenterToViewProtocol?
    
    public var youtubeKey: String?
        
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
    
    
}
