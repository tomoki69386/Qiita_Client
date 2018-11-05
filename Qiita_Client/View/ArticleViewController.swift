//
//  ArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import MarkdownView
import AMScrollingNavbar

final class ArticleViewController: UIViewController {
    
    private let article: Article
    private let mdView = MarkdownView()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = AppColor.white
        button.layer.borderWidth = 2.0
        button.layer.borderColor = AppColor.main.cgColor
        return button
    }()
    private let stockButton: UIButton = {
        let button = UIButton()
        
        return button
    }
    
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
        setLike()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(mdView, delay: 50.0)
        }
    }
    
    private func setLike() {
        likeButton.frame = CGRect(x: view.frame.width - 75, y: UIScreen.main.bounds.height, width: 60, height: 60)
        likeButton.layer.cornerRadius = likeButton.frame.width / 2
        view.addSubview(likeButton)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.likeButton.frame.origin.y -= (self.tabBarController?.tabBar.frame.height)! + 75
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
