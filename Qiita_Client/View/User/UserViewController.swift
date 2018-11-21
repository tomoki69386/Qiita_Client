//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit
import SDWebImage
import XLPagerTabStrip

class UserViewController: ButtonBarPagerTabStripViewController {
    
    @IBOutlet private weak var baseScrollView: UIScrollView!
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.main
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        label.text = "Kota Hibino"
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColor.main
        return imageView
    }()
    
    private let disposeBag = DisposeBag()
    private var scrollBeginingPoint: CGPoint!

    override func viewDidLoad() {
        setBarLayout()
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
        let imageURL = URL(string: "https://scontent-nrt1-1.xx.fbcdn.net/v/t1.0-9/30594824_442982472781144_5732347718363692662_n.jpg?_nc_cat=101&_nc_ht=scontent-nrt1-1.xx&oh=ab9ec3b27d7620463e33003551707b27&oe=5C6EEF4E")
        userImageView.sd_setImage(with: imageURL)
        baseScrollView.delegate = self
        scrollBeginingPoint = baseScrollView.contentOffset
    }
    
    private func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        scrollBeginingPoint = scrollView.contentOffset
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let navigationBarHeight = self.navigationController!.navigationBar.frame.maxY
        let tabBarHeight = tabBarController!.tabBar.frame.minY
        let spaceHeight = tabBarHeight - navigationBarHeight
        
        if (scrollView.contentOffset.y + navigationBarHeight) + spaceHeight > scrollView.contentSize.height && scrollView.isDragging {
            print("一番下")
        }
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            Storyboard.userArticle.instantiateViewController(),
            Storyboard.userLiktArticle.instantiateViewController(),
            Storyboard.userStock.instantiateViewController(),
        ]
    }
    
    private func showUser() {
        APIManager.call(UserRequest.get, disposeBag, onSuccess: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }
        APIManager.call(UserArticleRequest.get, disposeBag, onSuccess: { (response) in
            print(response)
        }) { (error) in
            print(error)
        }

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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        baseScrollView.addSubview(nameLabel)
        baseScrollView.addSubview(userImageView)
        
        let navigationBarHeight = self.navigationController!.navigationBar.frame.size.height
        let statuBarHeight = UIApplication.shared.statusBarFrame.size.height
        let topBar = statuBarHeight + navigationBarHeight
        let tabBarHeight = self.tabBarController!.tabBar.frame.size.height
        
        baseScrollView.frame = view.bounds
        nameLabel.frame = CGRect(x: 20, y: 40, width: self.view.frame.width / 2, height: 30)
        userImageView.frame = CGRect(x: self.view.frame.width - (20 + self.view.frame.width / 3),
                                     y: 20,
                                     width: self.view.frame.width / 3,
                                     height: self.view.frame.width / 3)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        buttonBarView.frame = CGRect(x: 0, y: userImageView.frame.maxY + 10, width: baseScrollView.frame.width, height: 40)
        containerView.frame = CGRect(x: 0,
                                     y: buttonBarView.frame.maxY,
                                     width: baseScrollView.frame.width,
                                     height: baseScrollView.frame.height - (40 + topBar + tabBarHeight))
        baseScrollView.contentSize = CGSize(width: baseScrollView.frame.width, height: containerView.frame.maxY)
    }
}
