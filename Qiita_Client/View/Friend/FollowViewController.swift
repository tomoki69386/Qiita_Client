//
//  FollowViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Alamofire
import XLPagerTabStrip

class FollowViewController: MainViewController {
    
    private let tableView = UITableView()
    private var users = [ProfileModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UserShowTableViewCell.self, forCellReuseIdentifier: "UserShowCell")
        tableView.rowHeight = 70
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        tableView.dataSource = self
        request()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func request() {
        UserAPI.fetchUserFollow { (result) in
            switch result {
            case .success(let decoded):
                self.users = decoded
                self.tableView.reloadData()
                
            case .failure(_, let statusCode):
                print(statusCode ?? "")
            }
        }
    }
}

extension FollowViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserShowCell", for: indexPath) as! UserShowTableViewCell
        cell.setUp(user: users[indexPath.row])
        return cell
    }
}

extension FollowViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "フォロー"
    }
}
