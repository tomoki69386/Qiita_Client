//
//  ArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import MarkdownView

final class ArticleViewController: UIViewController {
    
    private let article: String
    private let mdView = MarkdownView()
    
    init(article: String) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mdView.frame = view.bounds
        mdView.load(markdown: article)
        view.addSubview(mdView)
    }
}
