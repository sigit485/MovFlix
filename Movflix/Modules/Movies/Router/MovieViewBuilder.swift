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
}

