//
//  MovieRepository.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

protocol MovieRepositoryProtocol {
    func getMovies(category: MovieCategory, param: [String: Any], completion: @escaping (Result<MovieResponseEntity, Error>) -> Void)
}

final class MovieRepository: MovieRepositoryProtocol {
    
    fileprivate let remote: APIManager
    
    init(remote: APIManager) {
        self.remote = remote
    }
    
    func getMovies(category: MovieCategory, param: [String: Any], completion: @escaping (Result<MovieResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.selectedMovieEndpoint(of: category)
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(MovieResponseEntity.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(URLError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
