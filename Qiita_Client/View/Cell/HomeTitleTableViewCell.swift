//
//  HomeTitleTableViewCell.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SnapKit

class HomeTitleTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Qiita View"
        label.font = .systemFont(ofSize: 30)
        label.textColor = AppColor.black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self).offset(10)
            make.height.equalTo(50)
            make.top.bottom.equalTo(self.contentView)
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
