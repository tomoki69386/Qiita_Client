//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class UserViewController: MainViewController {
    
    private let scrollView = UIScrollView()
    private let profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
        scrollView.frame = view.bounds
        profileView.frame = view.bounds
        self.view.addSubview(scrollView)
        scrollView.addSubview(profileView)
    }
    
    private func showUser() {
//        APIClient.fetchUser { (user) in
//            DispatchQueue.main.sync {
//                guard let imageURL = URL(string: user.profile_image_url!) else { return }
//                self.imageView.sd_setImage(with: imageURL)
//                self.nameLabel.text = user.name
//            }
//        }
//        userArticles.removeAll()
//        APIClient.fetchUserArticle { (articles) in
//            self.userArticles = articles
//            DispatchQueue.main.sync {
//
//            }
//        }
    }
}
