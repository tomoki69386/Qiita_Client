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
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        userImageView.clipsToBounds = true
        let imageURL = URL(string: "https://qiita-image-store.s3.amazonaws.com/0/165815/profile-images/1518552294")
        userImageView.sd_setImage(with: imageURL)
        self.addSubview(userImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.frame = CGRect(x: 10, y: 10, width: 80, height: 80)
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
    }
}
