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

    override func viewDidLoad() {
        setBarLayout()
        super.viewDidLoad()
        
        navigationItem.title = "プロフィール"
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        baseScrollView.addSubview(nameLabel)
        baseScrollView.addSubview(userImageView)
        
        baseScrollView.frame = view.bounds
        
        nameLabel.frame = CGRect(x: 20, y: 40, width: self.view.frame.width / 2, height: 30)
        userImageView.frame = CGRect(x: self.view.frame.width - (20 + self.view.frame.width / 3),
                                     y: 20,
                                     width: self.view.frame.width / 3,
                                     height: self.view.frame.width / 3)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        baseScrollView.contentSize = CGSize(width: baseScrollView.frame.width, height: baseScrollView.frame.height * 2)
        buttonBarView.frame = CGRect(x: 0, y: userImageView.frame.maxY + 10, width: baseScrollView.frame.width, height: 40)
        containerView.frame = CGRect(x: 0, y: buttonBarView.frame.maxY, width: baseScrollView.frame.width, height: baseScrollView.frame.height - 40)
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [
            Storyboard.userArticle.instantiateViewController(),
            Storyboard.userLiktArticle.instantiateViewController()
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
