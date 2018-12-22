//
//  SettingViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import AMScrollingNavbar

class SettingViewController: MainViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let sections = ["アカウント", "サポート", "アプリについて"]
    private let accounts = ["ログアウト"]
    private let supports = ["お問い合わせ"]
    private let apps = ["利用規約", "プライバシーポリシー", "ライセンス"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwipeBack()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = AppColor.bgGlay

        navigationItem.title = "設定"
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.setting)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(tableView, delay: 50.0)
        }
    }
    
    private func alertView() {
        let alert = UIAlertController(title: "ログアウトしますか？", message: "また利用する場合\n再度ログインする必要があります", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ログアウト", style: .destructive, handler:{ (action: UIAlertAction!) -> Void in
            Tracker.screenName(.logout)
            AppUser.logout()
            self.performSegue(withIdentifier: "LogOut", sender: nil)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func lineAt() {
        let alert = UIAlertController(title: "お問い合わせ", message: "LINEに移動します", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "LINEへ", style: .default, handler: { (action: UIAlertAction) -> Void in
            Tracker.screenName(.info)
            guard let url = "https://line.me/R/ti/p/%40dtn0766u".url else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        })
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = apps[indexPath.row]
            cell.accessoryType = .disclosureIndicator
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
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.showNavbar()
        }
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            tableView.deselectRow(at: indexPath, animated: true)
            self.alertView()
            
        case (1, 0):
            tableView.deselectRow(at: indexPath, animated: true)
            self.lineAt()
            
        case (2, 0):
            Tracker.screenName(.service)
            let VC = InfoViewController(infoURL: .service)
            self.navigationController?.pushViewController(VC, animated: true)
            
        case (2, 1):
            Tracker.screenName(.privacy)
            let VC = InfoViewController(infoURL: .privacy)
            self.navigationController?.pushViewController(VC, animated: true)
            
        case (2, 2):
            Tracker.screenName(.license)
            tableView.deselectRow(at: indexPath, animated: true)
            guard let url = "app-settings:root=General&path=com.gekkado.lunascope".url else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        default: break
        }
    }
}
