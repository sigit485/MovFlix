//
//  TVInteractor.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol TVUseCase {
    func getTVShows(page: Int, category: TVCategory, completion: @escaping (Result<[TVResponseResult], Error>) -> Void)
}

class TVInteractor: TVUseCase {
    private let repository: TVRepositoryProtocol
    
    init(repository: TVRepositoryProtocol) {
        self.repository = repository
    }
    
    func getTVShows(page: Int, category: TVCategory, completion: @escaping (Result<[TVResponseResult], Error>) -> Void) {
        
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US",
            "page": page
        ]
        
        self.repository.getTVShows(category: category, param: parameters) { result in
            switch result {
            case .success(let data):
                let tvShows = data.results ?? []
                completion(.success(tvShows))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
