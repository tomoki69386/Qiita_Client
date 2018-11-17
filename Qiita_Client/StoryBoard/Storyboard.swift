//
//  Storyboard.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
class Storyboards {
    
    fileprivate init() {}
    
    static let tabBar = Storyboard<UITabBarController>(name: "TabBarController")
    
    static let homeNav = Storyboard<UINavigationController>(name: "Home")
    
    static let userNav = Storyboard<UINavigationController>(name: "User")
    static let userArticle = Storyboard<UIViewController>(name: "UserArticle")
    
}
// MARK: - Storyboard -
final class Storyboard<InitialVC: UIViewController>: Storyboards {
    
    let name: String
    
    // MARK: - Initializer
    
    fileprivate init(name: String) {
        self.name = name
    }
    
    // MARK: - Methods
    
    func instantiateViewController() -> InitialVC {
        let storyboard = UIStoryboard(name: self.name, bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() else {
            assertionFailure("\(self.name).storyboardでinitialVCが設定されていません")
            return InitialVC()
        }
        guard let initialVC = vc as? InitialVC else {
            assertionFailure("\(self.name).storyboardのinitialVCは\(type(of: vc.self))型です")
            return InitialVC()
        }
        return initialVC
    }
    
}
