//
//  HomeTrendTableViewCell.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SnapKit

class HomeTrendTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "今日のトレンド"
        label.font = .systemFont(ofSize: 25)
        label.textColor = AppColor.glay
        return label
    }()
    
    private let trendImageView = UIImageView(image: UIImage(named: "programming"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
        trendImageView.layer.cornerRadius = 5
        trendImageView.clipsToBounds = true
        self.addSubview(trendImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.top.equalTo(self).offset(5)
            make.height.equalTo(30)
        }
        
        trendImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(trendImageView.snp.width).multipliedBy(0.6)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
