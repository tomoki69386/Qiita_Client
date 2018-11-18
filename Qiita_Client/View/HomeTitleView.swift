//
//  HomeTitleView.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SnapKit

@IBDesignable
class HomeTitleView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Qiita View"
        label.font = .systemFont(ofSize: 40)
        label.textColor = AppColor.black
        return label
    }()
    
    private let trendLabel: UILabel = {
        let label = UILabel()
        label.text = "今日のトレンド"
        label.font = .systemFont(ofSize: 25)
        label.textColor = AppColor.glay
        return label
    }()
    
    private let trendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "programming")
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setUp()
    }
    
    private func setUp() {
        self.addSubview(titleLabel)
        self.addSubview(trendLabel)
        self.addSubview(trendImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(5)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        trendLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(30)
        }
        
        trendImageView.snp.makeConstraints { make in
            make.top.equalTo(trendLabel.snp.bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(trendImageView.snp.width).multipliedBy(0.6)
        }
    }

}
