//
//  DetailRepository.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol DetailRepositoryProtocol {
    func getDetailMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailMovieResponseEntity, Error>) -> Void)
    func getDetailTV(idTV: Int, param: [String : Any], completion: @escaping (Result<DetailTVResponseEntity, Error>) -> Void)
    func getVideosMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailVideoResponseEntity, Error>) -> Void)
    func getReviewMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailReviewResponseEntity, Error>) -> Void)
}

final class DetailRepository: DetailRepositoryProtocol {
    fileprivate let remote: APIManager
    
    init(remote: APIManager) {
        self.remote = remote
    }
    
    func getDetailMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailMovieResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.movie + "/\(idMovie)"
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(DetailMovieResponseEntity.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(URLError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getDetailTV(idTV: Int, param: [String : Any], completion: @escaping (Result<DetailTVResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.tv + "/\(idTV)"
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(DetailTVResponseEntity.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(URLError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getVideosMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailVideoResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.movie + "/\(idMovie)" + APIManager.videos
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(DetailVideoResponseEntity.self, from: data)
                    completion(.success(data))
                } catch {
                    completion(.failure(URLError.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getReviewMovie(idMovie: Int, param: [String : Any], completion: @escaping (Result<DetailReviewResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.movie + "/\(idMovie)" + APIManager.reviews
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(DetailReviewResponseEntity.self, from: data)
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
