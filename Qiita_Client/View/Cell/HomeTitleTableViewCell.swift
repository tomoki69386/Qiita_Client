//
//  HomeTitleTableViewCell.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/18.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

class HomeTitleTableViewCell: UITableViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Qiita View"
        label.font = .systemFont(ofSize: 30)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
