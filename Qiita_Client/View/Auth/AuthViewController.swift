//
//  AuthViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: MainViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSwipeBack()

        guard let url = URL(string: "https://qiita.com/api/v2/oauth/authorize?client_id=\(AppUser.clientID)&scope=read_qiita+write_qiita") else { return }
        let urlRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.auth)
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.scheme == "tomoki-qiita-client" {
            if navigationAction.request.url?.host == "oauth" && navigationAction.request.url?.lastPathComponent == "qiita" {
                guard let code = getQueryStringParameter(url: (navigationAction.request.url?.absoluteString)!, param: "code") else {
                    return
                }
                getAccessToken(code: code)
            }
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    
    private func getAccessToken(code: String!) {
        AppAPI.fetchAccessToken(code: code) { (result) in
            switch result {
            case .success(let decoded):
                AppUser.saveAccessToken(token: decoded.token)
                self.getUser()
            case .failure(let error, _):
                print(error)
                /// Token取得に失敗しました。
            }
        }
    }
    
    private func getUser() {
        UserAPI.fetchProfile { (result) in
            switch result {
            case .success(let decoded):
                AppUser.saveUser(user: decoded)
                self.performSegue(withIdentifier: "toTabBar", sender: nil)
            case .failure(let error, _):
                print(error)
                /// User情報の取得に失敗しました。
            }
        }
    }
}
