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
    
    private var articles = [Article]()
    private var scrollBeginingPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        scrollBeginingPoint = tableView.contentOffset
        request()
    }
    
    private func request() {
        let url = "https://qiita.com/api/v2/authenticated_user/items?page=1&per_page=20"
        let headers = [
            "Content-type": "application/json",
            "ACCEPT": "application/json",
            "Authorization": "Bearer \(AppUser.accessToken)"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                print(response)
                let result = try! decoder.decode(Array<Article>.self, from: data)
                self.articles = result
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
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
        cell.dataSet(article: articles[indexPath.row])
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
