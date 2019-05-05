//
//  NewArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/29.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Device
import RxSwift
import RxCocoa
import StoreKit
import Alamofire

class NewArticleViewController: UIViewController {

    private let refreshControl = UIRefreshControl()
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            tableView.refreshControl = refreshControl
            tableView.rowHeight = 90
            tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        }
    }
    
    private lazy var viewModel = NewArticleViewModel(
        itemSelected: tableView.rx.itemSelected.asObservable())
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.deselectRow
        .bind(to: deselectRow)
        .disposed(by: disposeBag)
        
        viewModel.reloadData
        .bind(to: reloadData)
        .disposed(by: disposeBag)
        
        viewModel.transitionToArticleDetail
        .bind(to: transitionToArticleDetail)
        .disposed(by: disposeBag)

        navigationItem.title = "新着記事"
        
        if AppUser.countUp() && !Device.isSimulator() {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.articleList)
    }
    
    private var deselectRow: Binder<IndexPath> {
        return Binder(self) { me, indexPath in
            me.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    private var reloadData: Binder<Void> {
        return Binder(self) { me, _ in
            me.tableView.reloadData()
        }
    }
    private var transitionToArticleDetail: Binder<ArticleModel> {
        return Binder(self) { me, article in
            let target = ArticleViewController(article: article)
            me.navigationController?.pushViewController(target, animated: true)
        }
    }
}

extension NewArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.setUp(article: viewModel.articles[indexPath.row])
        return cell
    }
}
