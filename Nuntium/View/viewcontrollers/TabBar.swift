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
        let home = UINavigationController(rootViewController: router.homeVC())
        home.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        viewControllers = [home]
    }

}
