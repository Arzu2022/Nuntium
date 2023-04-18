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
        let router = Router()
//        var t = FavoriteTopicVC(vm: FavoriteTopicViewModel(), router: router)
//        var y = CategoryVC(vm: CategoryViewModel(), router: router)
//        y.delegateCell = t as? SelectedCell
        self.view.backgroundColor = .white
        tabBar.tintColor = UIColor(named:"PurpleC")
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor(white: 0.8, alpha: 0.8).cgColor
        let home = router.homeVC()
        //UINavigationController(rootViewController: router.homeVC())
        let category = router.categoryVC()
        //UINavigationController(rootViewController: router.categoryVC())
        let bookmark = router.bookmarkVC()
        //UINavigationController(rootViewController: router.bookmarkVC())
        let profile = router.profileVC()
        //UINavigationController(rootViewController: router.profileVC())
        home.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"))
        category.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "category"), selectedImage: UIImage(named: "category"))
        bookmark.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "save"), selectedImage: UIImage(named: "save"))
        profile.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        viewControllers = [home,category,bookmark,profile]
    }

}
