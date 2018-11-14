//
//  HomeViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: ButtonBarPagerTabStripViewController {
    
    
    override func viewDidLoad() {
        setBarLayout()
        super.viewDidLoad()
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            Storyboard.newArticle.instantiateViewController(),
            Storyboard.hogeView.instantiateViewController()
        ]
    }
    
    private func setBarLayout() {
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.buttonBarItemTitleColor = AppColor.main
        settings.style.selectedBarBackgroundColor = AppColor.main
        settings.style.selectedBarHeight = 2.5
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) in
            guard changeCurrentIndex else { return }
            oldCell?.label.textColor = .gray
            oldCell?.label.font = UIFont.systemFont(ofSize: CGFloat(15))
            newCell?.label.textColor = AppColor.main
            newCell?.label.font = UIFont.boldSystemFont(ofSize: 15)
        }
    }
}
