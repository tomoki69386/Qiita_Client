//
//  LikeButton.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/21.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

@IBDesignable
class LikeButton: UIButton {

    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.backgroundColor = AppColor.main
            } else {
                self.backgroundColor = AppColor.white
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(named: "like"), for: .normal)
        self.setImage(UIImage(named: "like_true"), for: .selected)
        self.layer.borderWidth = 2.0
        self.layer.borderColor = AppColor.main.cgColor
        self.clipsToBounds = true
        self.layer.shadowColor = AppColor.bgGlay.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
