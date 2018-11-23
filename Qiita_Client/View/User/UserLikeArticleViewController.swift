//
//  UserLikeArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Alamofire
import XLPagerTabStrip

class UserLikeArticleViewController: MainViewController {
    
    private var articles = [Article]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 90
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
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
                let result = try! decoder.decode(Array<Article>.self, from: data)
                self.articles = result
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = self.view.bounds
    }
}

extension UserLikeArticleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleTableViewCell
        cell.dataSet(article: articles[indexPath.row])
        return cell
    }
}

extension UserLikeArticleViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension UserLikeArticleViewController: UITableViewDelegate {
    
}

extension UserLikeArticleViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "いいね"
    }
}
