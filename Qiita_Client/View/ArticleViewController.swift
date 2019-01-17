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
    
    private let article: ArticleModel
    private let mdView = MarkdownView()
    
    private let likeButton = LikeButton()
    private let stockButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.glay
        button.setImage(UIImage(named: "stock"), for: .normal)
        button.setImage(UIImage(named: "like_true"), for: .selected)
        button.clipsToBounds = true
        return button
    }()
    
    init(article: ArticleModel) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwipeBack()
        navigationItem.title = article.title
        
        getStatus()
        setLayout()
        setButtonHidden(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.readArticle)

        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(mdView, delay: 50.0)
        }
    }
    
    private func setLayout() {
        mdView.frame = view.bounds
        mdView.load(markdown: article.body)
        view.addSubview(mdView)
        
        likeButton.layer.cornerRadius = 30
        stockButton.layer.cornerRadius = 30
        likeButton.frame = CGRect(x: view.frame.width - 75, y: UIScreen.main.bounds.height, width: 60, height: 60)
        stockButton.frame = CGRect(x: view.frame.width - 75, y: UIScreen.main.bounds.height, width: 60, height: 60)
        view.addSubview(likeButton)
        view.addSubview(stockButton)
        
        likeButton.rx.tap.subscribe(onNext: { _ in
            if AppUser.id == self.article.user.id {
                return PopUp().alert(message: "自分の投稿にいいね出来ません")
            }
            Tracker.event(.like)
            if self.likeButton.isSelected {
                self.deleteLike()
            } else {
                self.putLike()
            }
        }).disposed(by: self.disposeBag)
        
        stockButton.rx.tap.subscribe(onNext: { _ in
            if AppUser.id == self.article.user.id {
                return PopUp().alert(message: "自分の投稿をストック出来ません")
            }
            Tracker.event(.stock)
            if self.stockButton.isSelected {
                self.deleteStock()
            } else {
                self.putStock()
            }
        }).disposed(by: self.disposeBag)
    }
    
    private func getStatus() {
        ArticleAPI.getLike(id: article.id) { (result) in
            switch result {
            case .success:
                self.likeButton.isSelected = true
            case .failure(_, _):
                self.likeButton.isSelected = false
            }
        }
        
        ArticleAPI.getStock(id: article.id) { (result) in
            switch result {
            case .success:
                self.stockButton.isSelected = true
            case .failure(_, _):
                self.stockButton.isSelected = false
            }
        }
    }
    
    private func putLike() {
        ArticleAPI.putLike(id: article.id) { (result) in
            switch result {
            case .success:
                self.likeButton.isSelected = true
            case .failure(_, _):
                self.likeButton.isSelected = false
            }
        }
    }
    
    private func deleteLike() {
        ArticleAPI.deleteLike(id: article.id, completion: { (result) in
            switch result {
            case .success:
                self.likeButton.isSelected = false
            case .failure(_, _):
                self.likeButton.isSelected = true
            }
        })
    }
    
    private func putStock() {
        ArticleAPI.putStock(id: article.id) { (result) in
            switch result {
            case .success:
                self.stockButton.isSelected = true
            case .failure(_, _):
                self.stockButton.isSelected = false
            }
        }
    }
    
    private func deleteStock() {
        ArticleAPI.deleteStock(id: article.id) { (result) in
            switch result {
            case .success:
                self.stockButton.isSelected = false
            case .failure(_, _):
                self.stockButton.isSelected = true
            }
        }
    }
    
    private func setButtonHidden(_ hidden: Bool, completion: @escaping (Bool) -> Void = { _ in}) {
        guard let tabBarHeight = self.tabBarController?.tabBar.frame.height else { return }
        let screenHeight = UIScreen.main.bounds.height
        if hidden {
            UIView.animate(withDuration: 0.5) {
                self.stockButton.frame.origin = CGPoint(x: self.view.frame.width - 75, y: screenHeight - (tabBarHeight + 75))
                self.likeButton.frame.origin = CGPoint(x: self.view.frame.width - 75, y: screenHeight - (tabBarHeight + 150))
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.stockButton.frame.origin.y = screenHeight
                self.likeButton.frame.origin.y = screenHeight
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
