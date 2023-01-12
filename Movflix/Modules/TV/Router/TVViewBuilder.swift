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
}
