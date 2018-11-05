//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SkeletonView
import MarkdownView

class UserViewController: UIViewController {
    
    let md = MarkdownView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        md.frame = view.bounds
        md.load(markdown: "# Hello World!")
        view.addSubview(md)

    }

}
