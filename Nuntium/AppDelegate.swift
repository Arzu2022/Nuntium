//
//  AppDelegate.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let router = Router()
        let vc = UINavigationController(rootViewController: router.initialVC())
        self.window?.rootViewController = TabBar()
        self.window?.makeKeyAndVisible()
        return true
    }


}

