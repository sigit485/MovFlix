//
//  TVListPresenter.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol TVListPresenterProtocol {
    func getListTVShow(category: TVCategory)
    func loadMoreTVShow(category: TVCategory)
}

class TVListPresenter: TVListPresenterProtocol {
    
    private let tvUseCase: TVUseCase
    private let delegate: PresenterToViewProtocol?
    
    private var pagination: Int = 1
    public var listTV: [TVResponseResult] = []
    public var indexPaths: [IndexPath] = []
    
    init(tvUseCase: TVUseCase, delegate: PresenterToViewProtocol) {
        self.tvUseCase = tvUseCase
        self.delegate = delegate
    }
    
    func getListTVShow(category: TVCategory) {
        delegate?.showLoading()
        tvUseCase.getTVShows(page: pagination, category: category) { result in
            switch result {
            case .success(let data):
                self.listTV = data
                self.delegate?.dismissLoading()
                self.delegate?.successLoadData(object: NSObject())
            case .failure(let error):
                self.delegate?.dismissLoading()
                self.delegate?.failedLoadData(Error: error)
            }
        }
    }
    
    func loadMoreTVShow(category: TVCategory) {
        pagination += 1
        
        delegate?.showLoading()
        tvUseCase.getTVShows(page: pagination, category: category) { result in
            switch result {
            case .success(let data):
                let startIndex = self.listTV.count - 1
                let endIndex = startIndex + data.count
                
                let tempIndexPaths = Array(startIndex..<endIndex).compactMap { return IndexPath(row: $0, section: 0) }
                self.indexPaths = tempIndexPaths
                
                self.listTV.append(contentsOf: data)
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
