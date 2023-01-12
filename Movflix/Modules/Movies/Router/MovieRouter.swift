//
//  MovieRouter.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MovieRouter {
    
    func setRoot() -> UINavigationController {
        let vc = MovieViewBuilder.makeMovieView(router: self)
        vc.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "tab_ic_movie"), tag: 0)
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    func pushToList(from rootViewController: UIViewController, category: MovieCategory) {
        let vc = MovieViewBuilder.makeListMovieView(router: self, category: category)
        vc.hidesBottomBarWhenPushed = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
}
