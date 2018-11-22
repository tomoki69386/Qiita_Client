//
//  AuthViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let clientid = AppUser.clientID else { fatalError("定義されていません。") }
        let url = URL(string: "https://qiita.com/api/v2/oauth/authorize?client_id=\(clientid)&scope=read_qiita+write_qiita")
        let urlRequest = URLRequest(url: url!)
        self.webView.load(urlRequest)
    }
    
    override func loadView() {
        self.view = self.webView
    }
    
}
