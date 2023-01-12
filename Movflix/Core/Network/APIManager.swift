//
//  APIManager.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation
import Alamofire

protocol RemoteSourceProtocol {
    func fetchRequest(endpoint: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<Data, Error>) -> Void)
}

class APIManager: RemoteSourceProtocol {
    
    func fetchRequest(endpoint: String, method: HTTPMethod, parameters: Parameters?, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = APIManager.baseURL + endpoint
        if let url = URL(string: url) {
            AF.request(url, method: method, parameters: parameters).responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure:
                    completion(.failure(URLError.invalidResponse))
                }
            }
        } else {
            completion(.failure(URLError.addressUnreachable))
        }
    }
}
