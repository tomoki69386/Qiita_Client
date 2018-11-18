//
//  HomeViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import SkeletonView

class HomeViewController: MainViewController {
    
    private var items = [Article]()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "Home")
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showAnimatedGradientSkeleton()
        
        navigationItem.title = "記事一覧"
        
        showRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
    }
    
    private func showRequest() {
        items.removeAll()
        APIClient.fetchArticle { (articles) in
            self.items = articles
            DispatchQueue.main.sync {
                self.tableView.hideSkeleton()
                self.tableView.reloadData()
            }
        }
        APIManager.call(UserRequest.get, disposeBag, onSuccess: { item in
            print(item)
        }, onError: {_ in
            
        })
    }
}

extension HomeViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "Home"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Home", for: indexPath) as! HomeTableViewCell
        cell.setup(item: items[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let VC = ArticleViewController(article: items[indexPath.row])
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
