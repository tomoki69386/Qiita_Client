//
//  ArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import MarkdownView
import AMScrollingNavbar

final class ArticleViewController: MainViewController {
    
    private let article: Article
    private let mdView = MarkdownView()
    
    private let headers = [
        "Content-type": "application/json",
        "ACCEPT": "application/json",
        "Authorization": "Bearer \(AppUser.accessToken)"
    ]
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = AppColor.main.cgColor
        button.setImage(UIImage(named: "like"), for: .normal)
        button.setImage(UIImage(named: "like_true"), for: .selected)
        button.clipsToBounds = true
        return button
    }()
    private let stockButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.glay
        button.setImage(UIImage(named: "stock"), for: .normal)
        button.setImage(UIImage(named: "like_true"), for: .selected)
        button.clipsToBounds = true
        return button
    }()
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = article.title
        
        mdView.frame = view.bounds
        mdView.load(markdown: article.body)
        view.addSubview(mdView)
        stockRequest()
        likeRequest()
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(mdView, delay: 50.0)
        }
    }
    
    private func setBtn() {
        likeButton.frame = CGRect(x: view.frame.width - 75, y: UIScreen.main.bounds.height, width: 60, height: 60)
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        view.addSubview(likeButton)
        
        stockButton.frame = CGRect(x: view.frame.width - 75, y: UIScreen.main.bounds.height, width: 60, height: 60)
        stockButton.layer.cornerRadius = stockButton.frame.width / 2
        view.addSubview(stockButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.stockButton.frame.origin.y -= (self.tabBarController?.tabBar.frame.height)! + 75
            self.likeButton.frame.origin.y -= (self.tabBarController?.tabBar.frame.height)! + 150
        })
        
        likeButton.rx.tap.subscribe(onNext: { _ in
            self.likeButton.isSelected = !self.likeButton.isSelected
            if self.likeButton.isSelected {
                self.likeButton.backgroundColor = AppColor.main
            } else {
                self.likeButton.backgroundColor = AppColor.white
            }
        }).disposed(by: self.disposeBag)
        
        stockButton.rx.tap.subscribe(onNext: { _ in
            self.stockButton.isSelected = !self.stockButton.isSelected
        }).disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleViewController {
    private func stockRequest() {
        let url = "https://qiita.com/api/v2/items/\(article.id)/stock"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            switch response.result {
            case .success:
                guard let code = response.response?.statusCode else { return }
                if code == 204 {
                    self.stockButton.isSelected = true
                } else {
                    self.stockButton.isSelected = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func likeRequest() {
        let url = "https://qiita.com/api/v2/items/\(article.id)/like"
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            switch response.result {
            case .success:
                guard let code = response.response?.statusCode else { return }
                if code == 204 {
                    self.likeButton.isSelected = true
                    self.likeButton.backgroundColor = AppColor.main
                } else {
                    self.likeButton.isSelected = false
                    self.likeButton.backgroundColor = AppColor.white
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
