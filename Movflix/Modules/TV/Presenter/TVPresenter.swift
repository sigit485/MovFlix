//
//  TVPresenter.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol TVPresenterProtocol {
    func getOnAirShows(page: Int)
    func getTopRated(page: Int)
    func getPopular(page: Int)
}

class TVPresenter: TVPresenterProtocol {
    private let tvUseCase: TVUseCase
    private let delegate: PresenterToViewProtocol?
    
    public var onAirShows: [TVResponseResult] = []
    public var topRated: [TVResponseResult] = []
    public var popular: [TVResponseResult] = []
    
    init(tvUseCase: TVUseCase, delegate: PresenterToViewProtocol?) {
        self.tvUseCase = tvUseCase
        self.delegate = delegate
    }
    
    func getOnAirShows(page: Int) {
        let category = TVCategory.onAir
        
        delegate?.showLoading()
        tvUseCase.getTVShows(page: page, category: category) { result in
            switch result {
            case .success(let data):
                self.onAirShows = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: category)
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func getTopRated(page: Int) {
        let category = TVCategory.topRated
        delegate?.showLoading()
        tvUseCase.getTVShows(page: page, category: category) { result in
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
        let category = TVCategory.popular
        delegate?.showLoading()
        tvUseCase.getTVShows(page: page, category: category) { result in
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
