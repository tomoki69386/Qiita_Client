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
    private var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UserShowTableViewCell.self, forCellReuseIdentifier: "UserShowCell")
        tableView.rowHeight = 70
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        request()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func request() {
        let url = "https://qiita.com/api/v2/users/\(AppUser.id)/followees"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: APIClient.headers).responseJSON{ response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                let result = try! decoder.decode(Array<User>.self, from: data)
                self.users = result
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
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

extension FollowViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FollowViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "フォロー"
    }
}
