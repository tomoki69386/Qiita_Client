//
//  NewArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/29.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Device
import StoreKit
import Alamofire
import AMScrollingNavbar

class NewArticleViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        table.rowHeight = 90
        return table
    }()
    
    private var articles = [ArticleModel]()
    private var isaddload: Bool = true
    private var currentIndex = 0
    private let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "新着記事"
        
        activityIndicator.center = view.center
        activityIndicator.color = .white
        tableView.addSubview(activityIndicator)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        activityIndicator.startAnimating()
//        request {
//            self.activityIndicator.stopAnimating()
//        }
        
        if AppUser.countUp() && !Device.isSimulator() {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.articleList)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
    }
    
    @objc private func refreshControlAction(refreshControl: UIRefreshControl) {
        currentIndex = 0
        request {
            refreshControl.endRefreshing()
        }
    }
    private func request(completion: @escaping () -> Void = { }) {
        currentIndex += 1
        ArticleAPI.fetchNewArticle(in: currentIndex) { (resule) in
            switch resule {
            case .success(let decoded):
                self.articles += decoded
                self.tableView.reloadData()
                self.isaddload = true
                completion()
            case .failure(_, let statusCode):
                print(statusCode ?? "")
            }
        }
    }
}

extension NewArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        cell.setUp(article: articles[indexPath.row])
        return cell
    }
}

extension NewArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar()
        }
        let VC = ArticleViewController(article: articles[indexPath.row])
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if tableView.contentOffset.y + tableView.frame.size.height > tableView.contentSize.height && tableView.isDragging && isaddload == true {
            self.isaddload = false
            self.request()
        }
    }
}
