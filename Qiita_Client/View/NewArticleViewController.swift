//
//  NewArticleViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/11.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class NewArticleViewController: MainViewController {
    
    private var itemInfo: IndicatorInfo = "新着記事"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewArticleViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}
