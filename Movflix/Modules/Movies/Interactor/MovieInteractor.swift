//
//  MovieInteractor.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

protocol MovieUseCase {
    func getMovieGenreList(completion: @escaping (Result<[GenreResult], Error>) -> Void)
    func getMovies(page: Int, category: MovieCategory, completion: @escaping (Result<[MovieResponseResult], Error>) -> Void)
}

class MovieInteractor: MovieUseCase {
    
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovieGenreList(completion: @escaping (Result<[GenreResult], Error>) -> Void) {
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US"
        ]
        
        repository.getMovieGenreList(param: parameters) { result in
            switch result {
            case .success(let data):
                let genres = data.genres ?? []
                completion(.success(genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovies(page: Int, category: MovieCategory, completion: @escaping (Result<[MovieResponseResult], Error>) -> Void) {
        
        let parameters: [String:Any] = [
            "api_key": APIManager.apiKey,
            "language": "en-US",
            "page": page
        ]
        
        repository.getMovies(category: category, param: parameters) { result in
            switch result {
            case .success(let data):
                let movies = data.results ?? []
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
