//
//  TabBar.swift
//  Nuntium
//
//  Created by AziK's  MAC on 12.04.23.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        self.view.backgroundColor = .white
        let router = Router()
        tabBar.tintColor = UIColor(named:"PurpleC")
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        let home = UINavigationController(rootViewController: router.homeVC())
        home.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        viewControllers = [home]
    }

}
