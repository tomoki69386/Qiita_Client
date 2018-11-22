//
//  FriendViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class FriendViewController: ButtonBarPagerTabStripViewController {
    
    private let firstOpenedRecipePosition: Int

    override func viewDidLoad() {
        setBarLayout()
        super.viewDidLoad()
        
        self.view.backgroundColor = AppColor.white
    }
    
    init(at recipePosition: Int) {
        self.firstOpenedRecipePosition = recipePosition
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.moveToViewController(at: self.firstOpenedRecipePosition, animated: false)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            Storyboard.follow.instantiateViewController(),
            Storyboard.follower.instantiateViewController()
        ]
    }
    
    private func setBarLayout() {
        settings.style.buttonBarBackgroundColor = AppColor.white
        settings.style.buttonBarItemBackgroundColor = AppColor.white
        settings.style.buttonBarItemTitleColor = AppColor.main
        settings.style.selectedBarBackgroundColor = AppColor.main
        settings.style.selectedBarHeight = 2.5
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) in
            guard changeCurrentIndex else { return }
            oldCell?.label.textColor = AppColor.glay
            oldCell?.label.font = .systemFont(ofSize: CGFloat(15))
            newCell?.label.textColor = AppColor.main
            newCell?.label.font = .boldSystemFont(ofSize: 15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
