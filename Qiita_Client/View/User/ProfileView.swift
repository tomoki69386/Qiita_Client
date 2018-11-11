//
//  ProfileView.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/11.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileView: UIView {
    
    private let userImageView = UIImageView()
    private let nameLabel = UILabel()
    private let userIDLabel = UILabel()
    private let profileLabel = UILabel()
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        userImageView.clipsToBounds = true
        let imageURL = URL(string: "https://qiita-image-store.s3.amazonaws.com/0/165815/profile-images/1518552294")
        userImageView.sd_setImage(with: imageURL)
        self.addSubview(userImageView)
        
        nameLabel.text = "ともき"
        self.addSubview(nameLabel)
        
        userIDLabel.text = "@tomoki_sun"
        self.addSubview(userIDLabel)
        
        profileLabel.text = "プログラミング大好きだよ♡"
        profileLabel.sizeToFit()
        self.addSubview(profileLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        
        nameLabel.frame = CGRect(x: 10, y: userImageView.frame.maxY + 10, width: self.frame.width, height: 19)
        userIDLabel.frame = CGRect(x: 10, y: nameLabel.frame.maxY + 10, width: self.frame.width, height: 14)
        profileLabel.frame = CGRect(x: 10, y: userIDLabel.frame.maxY + 10, width: self.frame.width - 20, height: 14)
    }
}
