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
        
        mdView.frame = view.bounds
        mdView.load(markdown: article.body)
        view.addSubview(mdView)
        
        getStatus()
        setBtn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.readArticle)

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
    
    private func messagePopup(message: String) {
        let messageView = MessagePopupView(frame: self.view.bounds, message: message)
        let bgView = UIButton(frame: self.view.bounds)
        bgView.backgroundColor = AppColor.black
        bgView.alpha = 0.5
        self.tabBarController?.view.addSubview(bgView)
        self.tabBarController?.view.addSubview(messageView)
        bgView.rx.tap.subscribe(onNext: { _ in
            messageView.removeFromSuperview()
            bgView.removeFromSuperview()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
