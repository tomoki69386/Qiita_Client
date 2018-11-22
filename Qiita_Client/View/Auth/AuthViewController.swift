//
//  AuthViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clientid = AppUser.clientID else { fatalError("定義されていません。") }
        let url = URL(string: "https://qiita.com/api/v2/oauth/authorize?client_id=\(clientid)&scope=read_qiita+write_qiita")
        let urlRequest = URLRequest(url: url!)
        self.webView.load(urlRequest)
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
                let code = getQueryStringParameter(url: (navigationAction.request.url?.absoluteString)!, param: "code")
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
        let url = "https://qiita.com/api/v2/access_tokens"
        guard let code = code else { return }
        
        // 受信可能なレスポンスデータのメディアタイプを指定
        let headers = [
            "ACCEPT": "application/json"
        ]
        
        // 認証に必要な値を設定
        let clientID: String = AppUser.clientID!
        let clientSecret: String = AppUser.clientSecret!
        let parameters: Parameters = [
            "client_id": clientID,
            "client_secret": clientSecret,
            "code": code
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ response in
            print(parameters)
            print(url)
            print(headers)
            print(response)
            switch response.result {
            case .success:
                print(response)
//                let json = JSON(response.result.value)
//
//                // アクセストークンを取得
//                let accessToken = json["access_token"].string
//                UserDefaults.standard.set(accessToken!, forKey: ACCESS_TOKEN)
//                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
