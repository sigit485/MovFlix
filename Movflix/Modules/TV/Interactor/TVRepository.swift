//
//  TVRepository.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

protocol TVRepositoryProtocol {
    func getTVShows(category: TVCategory, param: [String: Any], completion: @escaping (Result<TVResponseEntity, Error>) -> Void)
}

final class TVRepository: TVRepositoryProtocol {
    
    fileprivate let remote: APIManager
    
    init(remote: APIManager) {
        self.remote = remote
    }
    
    func getTVShows(category: TVCategory, param: [String : Any], completion: @escaping (Result<TVResponseEntity, Error>) -> Void) {
        let endpoint = APIManager.selectedTVEndpoint(of: category)
        self.remote.fetchRequest(endpoint: endpoint, method: .get, parameters: param) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(TVResponseEntity.self, from: data)
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
