//
//  AppDelegate.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        
        let router = Router()
        var vc = UINavigationController(rootViewController: router.initialVC())
        if let _ = Auth.auth().currentUser {
            vc = UINavigationController(rootViewController: TabBar())
        }
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        return true
    }
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }


}

