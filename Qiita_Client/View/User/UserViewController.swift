//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import SnapKit
import Alamofire
import SDWebImage

class UserViewController: MainViewController {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    private var userArticles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        showUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.width.height.equalTo(90)
            imageView.layer.cornerRadius = 45
            imageView.clipsToBounds = true
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }
    
    private func showUser() {
        APIClient.fetchUser { (user) in
            DispatchQueue.main.sync {
                guard let imageURL = URL(string: user.profile_image_url!) else { return }
                self.imageView.sd_setImage(with: imageURL)
                self.nameLabel.text = user.name
            }
        }
        userArticles.removeAll()
        APIClient.fetchUserArticle { (articles) in
            self.userArticles = articles
            DispatchQueue.main.sync {

            }
        }
    }
}
