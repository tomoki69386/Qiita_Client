//
//  MessagePopupView.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/21.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class MessagePopupView: UIView {
    
    private let containerView = UIView()
    private let messageLabel = UILabel()
    
    init(frame: CGRect, message: String) {
        messageLabel.text = message
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = false
        containerView.backgroundColor = AppColor.white
        containerView.layer.cornerRadius = 10
        self.addSubview(containerView)
        self.addSubview(messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(104)
            make.centerX.centerY.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
