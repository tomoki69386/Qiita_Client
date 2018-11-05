//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import MarkdownView

class UserViewController: UIViewController {
    
    let mdView = MarkdownView()

    override func viewDidLoad() {
        super.viewDidLoad()

        mdView.frame = view.bounds
        mdView.load(markdown: "# Markdown")
        view.addSubview(mdView)
    }

}
