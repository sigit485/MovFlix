//
//  TVRouter.swift
//  Movflix
//
//  Created by Sigit on 12/01/23.
//

import UIKit

class TVRouter {
    private let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    func setRoot() -> UINavigationController {
        let vc = TVViewBuilder.makeTVView(router: self)
        vc.tabBarItem = UITabBarItem(title: "TV Shows", image: UIImage(named: "tab_ic_tv"), tag: 1)
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
}
