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
import SDWebImage

class UserViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
        showUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
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
    }
    
    private func showUser() {
        APIClient.fetchUser{ (user) in
            print(user)
            guard let imageURL = URL(string: user.profile_image_url!) else { return }
            self.imageView.sd_setImage(with: imageURL)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
