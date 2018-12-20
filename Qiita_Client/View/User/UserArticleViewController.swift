//
//  UserArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/11.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Alamofire
import XLPagerTabStrip

class UserArticleViewController: MainViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        return tableView
    }()
    
    private var articles = [ArticleModel]()
    private var scrollBeginingPoint: CGPoint!
    private var isaddload: Bool = true
    private var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        scrollBeginingPoint = tableView.contentOffset
        request()
    }
    
    private func request() {
        
    }
    
    private func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollBeginingPoint = scrollView.contentOffset
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
}

extension UserArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        cell.setUp(article: articles[indexPath.row])
        return cell
    }
}

extension UserArticleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

extension UserArticleViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "投稿"
    }
}
