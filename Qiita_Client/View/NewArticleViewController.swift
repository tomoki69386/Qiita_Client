//
//  NewArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/29.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import StoreKit
import Alamofire

class NewArticleViewController: UIViewController {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.tableFooterView = UIView()
        table.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        table.rowHeight = 90
        return table
    }()
    
    private var articles = [Article]()
    private var isaddload: Bool = true
    private var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "新着記事"
        request()
        
        if AppUser.countUp() {
            SKStoreReviewController.requestReview()
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        tableView.frame = view.bounds
        self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        Tracker.event(.articleList)
    }
    
    private func request() {
        currentIndex += 1
        let url = "https://qiita.com/api/v2/items?page=\(currentIndex)&per_page=20"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: APIClient.headers).responseJSON{ response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                let result = try! decoder.decode(Array<Article>.self, from: data)
                self.articles += result
                self.tableView.reloadData()
                self.isaddload = true
            case .failure(let error):
                print(error)
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
