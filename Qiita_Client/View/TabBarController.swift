//
//  TabBarController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = AppColor.main
        let viewControllers = Tab.allCases.map { $0.instantiateViewController() }
        setViewControllers(viewControllers, animated: false)
    }
}

extension TabBarController {
    
    private enum Tab: CaseIterable {
        case home
        case user
        
        func instantiateViewController() -> UINavigationController {
            let nav: UINavigationController
            let tabBarItem: UITabBarItem
            switch self {
            case .home:
                nav = Storyboard.homeNav.instantiateViewController()
                tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home"))
            case .user:
                nav = Storyboard.userNav.instantiateViewController()
                tabBarItem = UITabBarItem(title: "", image: UIImage(named: "User"), selectedImage: UIImage(named: "User"))
            }
            tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            nav.tabBarItem = tabBarItem
            return nav
        }
    }
}
