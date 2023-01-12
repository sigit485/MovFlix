//
//  Injection.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import Foundation

final class Injection {
    
    private func provideMovieRepository() -> MovieRepositoryProtocol {
        let apiManager = APIManager()
        return MovieRepository(remote: apiManager)
    }
    
    private func provideTVRepository() -> TVRepositoryProtocol {
        let apiManager = APIManager()
        return TVRepository(remote: apiManager)
    }
    
    func provideMovie() -> MovieUseCase {
        let repository = provideMovieRepository()
        return MovieInteractor(repository: repository)
    }
    
    func provideTV() -> TVUseCase {
        let repository = provideTVRepository()
        return TVInteractor(repository: repository)
    }
    
}
