//
//  ArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import WebKit
import MarkdownView

final class ArticleViewController: UIViewController {
    
    private let articleURL: String
    private let webView = WKWebView()
    
    init(article: String) {
        self.articleURL = article
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

        let defaultURL: URL = URL(string: "https://qiita.com/404")!
        let urlRequest = URLRequest(url: URL(string: articleURL) ?? defaultURL)
        self.webView.load(urlRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
