//
//  DetailInteractor.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol DetailUseCase {
    func getDetailMovie(idMovie: Int, completion: @escaping (Result<DetailMovieResponseEntity, Error>) -> Void)
    func getDetailTV(idTV: Int, completion: @escaping (Result<DetailTVResponseEntity, Error>) -> Void)
    func getVideosMovie(idMovie: Int, completion: @escaping (Result<String?, Error>) -> Void)
    func getReviewsMovie(idMovie: Int, completion: @escaping (Result<[DetailReviewResult], Error>) -> Void)
}

class DetailInteractor: DetailUseCase {
    private let repository: DetailRepositoryProtocol
    
    init(repository: DetailRepositoryProtocol) {
        self.repository = repository
    }
    
    func getDetailMovie(idMovie: Int, completion: @escaping (Result<DetailMovieResponseEntity, Error>) -> Void) {
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US"
        ]
        
        repository.getDetailMovie(idMovie: idMovie, param: parameters) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailTV(idTV: Int, completion: @escaping (Result<DetailTVResponseEntity, Error>) -> Void) {
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US"
        ]
        
        repository.getDetailTV(idTV: idTV, param: parameters) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getVideosMovie(idMovie: Int, completion: @escaping (Result<String?, Error>) -> Void) {
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US"
        ]
        
        repository.getVideosMovie(idMovie: idMovie, param: parameters) { result in
            switch result {
            case .success(let data):
                // validate source from youtube
                if let firstData = data.results?.first, firstData.site == "YouTube" {
                    completion(.success(firstData.key))
                } else {
                    completion(.success(""))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getReviewsMovie(idMovie: Int, completion: @escaping (Result<[DetailReviewResult], Error>) -> Void) {
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US"
        ]
        
        repository.getReviewMovie(idMovie: idMovie, param: parameters) { result in
            switch result {
            case .success(let data):
                let reviews = data.results ?? []
                completion(.success(reviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
