//
//  UserArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/11.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class UserArticleViewController: MainViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        return tableView
    }()
    
    private var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        scrollBeginingPoint = tableView.contentOffset
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        cell.setUp()
        return cell
    }
}

extension UserArticleViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentPoint = scrollView.contentOffset
//        if scrollBeginingPoint.y < currentPoint.y {
//            print("下へスクロール")
//            scrollBeginingPoint = scrollView.contentOffset
//        } else {
//            print("上へスクロール")
//            scrollBeginingPoint = scrollView.contentOffset
//        }
//    }
}

extension UserArticleViewController: UITableViewDelegate {
    
}

extension UserArticleViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "投稿"
    }
}
