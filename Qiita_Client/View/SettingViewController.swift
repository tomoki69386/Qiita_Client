//
//  SettingViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let sections = ["アカウント", "サポート", "アプリについて"]
    private let accounts = ["ブックマーク", "ログアウト"]
    private let supports = ["お問い合わせ"]
    private let apps = ["アプリ開発者", "ライセンス"]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "設定"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = AppColor.bgGlay
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return accounts.count
        case 1:
            return supports.count
        case 2:
            return apps.count
        default:
            assertionFailure()
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = accounts[indexPath.row]
        case 1:
            cell.textLabel?.text = supports[indexPath.row]
        case 2:
            cell.textLabel?.text = apps[indexPath.row]
        default: break
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toInfo", sender: nil)
    }
}
