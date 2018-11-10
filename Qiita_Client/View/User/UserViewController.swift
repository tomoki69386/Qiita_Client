//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import AMScrollingNavbar
import SnapKit
import Alamofire
import SDWebImage

class UserViewController: MainViewController {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let tableView = UITableView()
    
    private var userArticles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(nameLabel)
        scrollView.addSubview(tableView)
        showUser()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.width.height.equalTo(90)
            imageView.layer.cornerRadius = 45
            imageView.clipsToBounds = true
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.left.equalTo(10)
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(self.nameLabel.snp.bottom).offset(20)
            make.left.equalTo(0)
            make.width.equalTo(self.scrollView.snp.width)
            make.height.equalTo(self.scrollView.snp.height)
        }
        print(tableView.frame)
    }
    
    private func showUser() {
        APIClient.fetchUser { (user) in
            DispatchQueue.main.sync {
                guard let imageURL = URL(string: user.profile_image_url!) else { return }
                self.imageView.sd_setImage(with: imageURL)
                self.nameLabel.text = user.name
            }
        }
        userArticles.removeAll()
        APIClient.fetchUserArticle { (articles) in
            self.userArticles = articles
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}

extension UserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! ProfileTableViewCell
        cell.textLabel?.text = userArticles[indexPath.row].title
        return cell
    }
}

extension UserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
