//
//  HomeViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class HomeViewController: MainViewController {
    
    private var items = [Article]()
//    private let tableView = UITableView()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "Home")
        tableView.register(HomeTitleTableViewCell.self, forCellReuseIdentifier: "HomeTitle")
        tableView.register(HomeTrendTableViewCell.self, forCellReuseIdentifier: "HomeTrend")
        tableView.separatorColor = .clear
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.dataSource = self
//        tableView.delegate = self
        
//        showRequest()
    }
    
    private func showRequest() {
        items.removeAll()
        APIClient.fetchArticle { (articles) in
            self.items = articles
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        APIManager.call(UserRequest.get, disposeBag, onSuccess: { item in
            print(item)
        }, onError: {_ in
            
        })
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            tableView.rowHeight = 50
            return homeTitleCell(at: indexPath, in: tableView)
        case 1:
            tableView.rowHeight = 270
            return homeTrendCell(at: indexPath, in: tableView)
        default:
            return homeTitleCell(at: indexPath, in: tableView)
        }
    }
    
    private func homeTitleCell(at indePath: IndexPath, in tableView: UITableView) -> HomeTitleTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "HomeTitle") as! HomeTitleTableViewCell
    }
    
    private func homeTrendCell(at indexPath: IndexPath, in tableView: UITableView) -> HomeTrendTableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "HomeTrend") as! HomeTrendTableViewCell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = ArticleViewController(article: items[indexPath.row])
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
