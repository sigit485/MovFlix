//
//  DetailViewBuilder.swift
//  Movflix
//
//  Created by Sigit on 13/01/23.
//

import Foundation

class DetailViewBuilder {
    
    static func makeReviewListView(router: DetailRouter, idMovie: Int) -> DetailReviewListView {
        let vc = DetailReviewListView()
        let interactor = Injection.init().provideDetail()
        let presenter = DetailPresenter(useCase: interactor, delegate: vc)
        vc.presenter = presenter
        vc.idMovie = idMovie
        return vc
    }
}
