//
//  AppDelegate.swift
//  Movflix
//
//  Created by Sigit on 10/01/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = MainTabBarView()
        window.makeKeyAndVisible()
        self.window = window

        return true
    }

}

