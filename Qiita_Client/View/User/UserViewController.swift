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
        APIManager.call(UserRequest.get, disposeBag, onSuccess: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
        APIManager.call(UserArticleRequest.get, disposeBag, onSuccess: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
    }
}
