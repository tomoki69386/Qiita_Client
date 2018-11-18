//
//  HomeViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class HomeViewController: MainViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height * 2)
    }
}
