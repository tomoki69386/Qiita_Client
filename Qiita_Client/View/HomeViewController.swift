//
//  HomeViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var items = [Article]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "記事一覧"
        navigationController?.navigationBar.barTintColor = AppColor.main
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        tableView.dataSource = self
        tableView.delegate = self
        
        showRequest()
    }
    
    private func showRequest() {
        items.removeAll()
        APIClient.fetchArticle { (articles) in
            self.items = articles
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].title
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.sizeToFit()
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row].url ?? "")
        guard let url = items[indexPath.row].url else { return }
        let VC = ArticleViewController(article: url)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
