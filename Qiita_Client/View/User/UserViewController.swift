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
    private let friendView = FriendView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.main
        label.font = .systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColor.main
        return imageView
    }()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        setBarLayout()
        super.viewDidLoad()
        
        
        navigationItem.title = "プロフィール"
        let backButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButtonItem
        
        let imageURL = URL(string: AppUser.profileImageURL)
        userImageView.sd_setImage(with: imageURL)
        nameLabel.text = AppUser.name
        friendView.friendDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.myPage)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            Storyboard.userArticle.instantiateViewController(),
            Storyboard.userStock.instantiateViewController(),
        ]
    }
    
    private func showUser() {

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
        baseScrollView.addSubview(friendView)
        
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
        friendView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.left.equalTo(nameLabel)
            make.width.equalTo(nameLabel)
            make.height.equalTo(35)
        }
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        buttonBarView.frame = CGRect(x: 0, y: userImageView.frame.maxY + 10, width: baseScrollView.frame.width, height: 40)
        containerView.frame = CGRect(x: 0,
                                     y: buttonBarView.frame.maxY,
                                     width: baseScrollView.frame.width,
                                     height: baseScrollView.frame.height - (40 + topBar + tabBarHeight))
        baseScrollView.contentSize = CGSize(width: baseScrollView.frame.width, height: containerView.frame.maxY)
    }
}

extension UserViewController: FriendViewDelegate {
    func didPushViewController(at index: Int) {
        let VC = FriendViewController(at: index)
        self.navigationController?.pushViewController(VC, animated: true)
    }
}
