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
        
        refreshControl.rx.controlEvent(.valueChanged)
            .map { _ in }
            .bind(to: viewModel.refreshTriggerSubject)
            .disposed(by: disposeBag)
        
        viewModel.loadedFirstData.map { _ in false }
            .drive(refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.deselectRow
            .bind(to: deselectRow)
            .disposed(by: disposeBag)
        
        viewModel.reloadData
            .bind(to: reloadData)
            .disposed(by: disposeBag)
        
        viewModel.transitionToArticleDetail
            .bind(to: transitionToArticleDetail)
            .disposed(by: disposeBag)
        
        viewModel
            .items
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "ArticleCell",
                                         cellType: ArticleTableViewCell.self)) { row, element, cell in
                                            cell.setUp(article: element)
            }
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
