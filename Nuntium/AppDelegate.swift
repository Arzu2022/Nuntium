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
        let vc = TabBar()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true
    }


}

