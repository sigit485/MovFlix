//
//  MovieViewBuilder.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MovieViewBuilder {
    static func makeMovieView(router: MovieRouter) -> MoviesView {
        let vc = MoviesView()
        let interactor = Injection.init().provideMovie()
        let presenter = MoviePresenter(movieUseCase: interactor, delegate: vc)
        vc.presenter = presenter
        vc.router = router
        return vc
    }
    
    static func makeListMovieView(router: MovieRouter, category: MovieCategory, idGenre: Int? = nil) -> MovieListView {
        let vc = MovieListView()
        let interactor = Injection.init().provideMovie()
        let presenter = MovieListPresenter(movieUseCase: interactor, delegate: vc)
        vc.presenter = presenter
        vc.router = router
        vc.category = category
        vc.idGenre = idGenre
        return vc
    }
    
    static func makeDetailMovieView(idMovie: Int) -> DetailView {
        let vc = DetailView()
        let interactor = Injection.init().provideDetail()
        let presenter = DetailPresenter(useCase: interactor, delegate: vc)
        let router = DetailRouter()
        vc.presenter = presenter
        vc.idMovie = idMovie
        vc.router = router
        return vc
    }
    
}

