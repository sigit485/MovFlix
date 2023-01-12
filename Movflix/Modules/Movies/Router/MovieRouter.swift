//
//  MovieRouter.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MovieRouter {
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func setRoot() -> UINavigationController {
        let vc = MovieViewBuilder.makeMovieView(router: self)
        vc.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "tab_ic_movie"), tag: 0)
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
}
