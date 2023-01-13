//
//  TVViewBuilder.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import Foundation

class TVViewBuilder {
    static func makeTVView(router: TVRouter) -> TelevisionView {
        let vc = TelevisionView()
        let interactor = Injection.init().provideTV()
        let presenter = TVPresenter(tvUseCase: interactor, delegate: vc)
        vc.presenter = presenter
        vc.router = router
        return vc
    }
    
    static func makeListTVView(router: TVRouter, category: TVCategory) -> TelevisionListView {
        let vc = TelevisionListView()
        let interactor = Injection.init().provideTV()
        let presenter = TVListPresenter(tvUseCase: interactor, delegate: vc)
        vc.presenter = presenter
        vc.router = router
        vc.category = category
        return vc
    }
    
    static func makeDetailTVView(idTV: Int) -> DetailView {
        let vc = DetailView()
        let interactor = Injection.init().provideDetail()
        let presenter = DetailPresenter(useCase: interactor, delegate: vc)
        let router = DetailRouter()
        vc.presenter = presenter
        vc.idTV = idTV
        vc.router = router
        vc.isDetailTV = true
        return vc
    }
}
