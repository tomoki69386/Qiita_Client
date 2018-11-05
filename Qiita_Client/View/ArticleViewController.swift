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
import MarkdownView
import AMScrollingNavbar

final class ArticleViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let article: Article
    private let mdView = MarkdownView()
    private var isLike: Bool = false {
        didSet {
            if isLike {
                likeButton.setImage(UIImage(named: "like_true"), for: .normal)
                likeButton.backgroundColor = AppColor.main
            }else {
                likeButton.setImage(UIImage(named: "like"), for: .normal)
                likeButton.backgroundColor = AppColor.white
                likeButton.layer.borderWidth = 2.0
                likeButton.layer.borderColor = AppColor.main.cgColor
            }
        }
    }
    private var isStock: Bool = false {
        didSet {
            if isStock {
                stockButton.setImage(UIImage(named: "like_true"), for: .normal)
            }else {
                stockButton.setImage(UIImage(named: "stock"), for: .normal)
                stockButton.backgroundColor = AppColor.glay
            }
        }
    }
    private let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = AppColor.main.cgColor
        button.setImage(UIImage(named: "like"), for: .normal)
        button.clipsToBounds = true
        return button
    }()
    private let stockButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.glay
        button.setImage(UIImage(named: "stock"), for: .normal)
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
        setBtn()
        btnEvent()
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
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.likeButton.frame.origin.y -= (self.tabBarController?.tabBar.frame.height)! + 150
            })
        })
    }
    
    private func btnEvent() {
        likeButton.rx.tap.subscribe(onNext: { _ in
            self.isLike = !self.isLike
        }).disposed(by: self.disposeBag)
        
        stockButton.rx.tap.subscribe(onNext: { _ in
            self.isStock = !self.isStock
        }).disposed(by: self.disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
