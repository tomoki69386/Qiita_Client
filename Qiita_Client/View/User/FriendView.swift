//
//  FriendView.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class FriendView: UIView {
    
    private let followCountLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        label.textColor = AppColor.glay
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let followLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.glay
        label.text = "フォロー"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let followerCountLabel: UILabel = {
        let label = UILabel()
        label.text = "123"
        label.textColor = AppColor.glay
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let followerLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.glay
        label.text = "フォロワー"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    private let rodView = UIView()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        rodView.backgroundColor = AppColor.glay
        
        self.addSubview(followCountLabel)
        self.addSubview(followLabel)
        self.addSubview(followerCountLabel)
        self.addSubview(followerLabel)
        self.addSubview(rodView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        followCountLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width / 2, height: 20)
        followLabel.frame = CGRect(x: 0, y: followCountLabel.frame.maxY, width: followCountLabel.frame.width, height: 15)
        rodView.frame = CGRect(x: followCountLabel.frame.maxX - 0.5, y: 0, width: 1, height: self.frame.height)
        followerCountLabel.frame = CGRect(x: followCountLabel.frame.maxX, y: 0, width: followCountLabel.frame.width, height: 20)
        followerLabel.frame = CGRect(x: followCountLabel.frame.maxX, y: followerCountLabel.frame.maxY, width: followCountLabel.frame.width, height: 15)
    }

}
