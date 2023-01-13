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
        vc.tabBarItem = UITabBarItem(title: TVConstant.tvShow, image: UIImage(named: "tab_ic_tv"), tag: 1)
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    func pushToList(from rootViewController: UIViewController, category: TVCategory) {
        let vc = TVViewBuilder.makeListTVView(router: self, category: category)
        vc.hidesBottomBarWhenPushed = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushToDetail(from rootViewController: UIViewController, idTV: Int) {
        let vc = TVViewBuilder.makeDetailTVView(idTV: idTV)
        vc.hidesBottomBarWhenPushed = true
        rootViewController.navigationController?.pushViewController(vc, animated: true)
    }
}
