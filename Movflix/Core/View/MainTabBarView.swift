//
//  MainTabBarView.swift
//  Movflix
//
//  Created by Sigit on 11/01/23.
//

import UIKit

class MainTabBarView: UITabBarController {
    lazy var homeView: UINavigationController = {
        let vc = MovieRouter()
        return vc.setRoot()
    }()
    
    lazy var tvView: UINavigationController = {
        let vc = TVRouter()
        return vc.setRoot()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViewControllers([homeView, tvView], animated: false)
        
        tabBar.tintColor = .black
    }
}
