//
//  InfoViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import WebKit

enum InfoURL {
    case service
    case privacy
    
    var title: String {
        switch self {
        case .service:
            return "利用規約"
        case .privacy:
            return "プライバシーポリシー"
        }
    }
    
    var url: URL {
        let baseURL = "https://tomoki69386.github.io/Qiita_Client"
        switch self {
        case .service:
            return URL(string: baseURL + "/Service/Service")!
        case .privacy:
            return URL(string: baseURL + "/Privacy/Privacy")!
        }
    }
}

class InfoViewController: MainViewController {
    
    private let infoURL: InfoURL
    private let webView = WKWebView()
    
    init(infoURL: InfoURL) {
        self.infoURL = infoURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeBack()
        
        self.title = self.infoURL.title
        
        let urlRequest = URLRequest(url: self.infoURL.url)
        self.webView.load(urlRequest)
    }
}
