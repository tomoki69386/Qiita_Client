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
    private let apps = ["利用規約", "プライバシーポリシー", "ライセンス"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = AppColor.bgGlay

        navigationItem.title = "設定"
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
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
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            print("ブックマーク")
        case (0, 1):
            print("ログアウト")
        case (1, 0):
            print("お問い合わせ")
        case (2, 0):
            print("利用規約")
        case (2, 1):
            print("プライバシーポリシー")
        case (2, 2):
            print("ライセンス")
        default: break
        }
        performSegue(withIdentifier: "toInfo", sender: nil)
    }
}
