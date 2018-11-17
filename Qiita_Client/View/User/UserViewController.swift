//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import RxSwift
import XLPagerTabStrip

class UserViewController: ButtonBarPagerTabStripViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
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
