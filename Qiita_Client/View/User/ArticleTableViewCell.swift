//
//  ProfileTableViewCell.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/09.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class ArticleTableViewCell: UITableViewCell {
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColor.glay
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.numberOfLines = 2
        return label
    }()
    
    private let likeImageView = UIImageView(image: UIImage(named: "like"))
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.main
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let tagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = AppColor.glay
        return label
    }()
    
    private let createdLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = AppColor.glay
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(userImageView)
        self.addSubview(titleLabel)
        self.addSubview(likeImageView)
        self.addSubview(likeCountLabel)
        self.addSubview(tagLabel)
        self.addSubview(createdLabel)
    }
    
    func setUp(article: ArticleModel) {
        let imageURL = URL(string: article.user.profileImageURL)
        userImageView.sd_setImage(with: imageURL)
        titleLabel.text = article.title
        likeCountLabel.text = String(article.likesCount)
        createdLabel.text = article.createdAt
        for i in article.tags {
            tagLabel.text = "#\(i.name)"
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.snp.makeConstraints { make in
            make.top.left.equalTo(self).offset(10)
            make.width.height.equalTo(60)
        }
        
        likeImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.width.height.equalTo(30)
        }
        
        likeCountLabel.snp.makeConstraints { make in
            make.top.equalTo(likeImageView.snp.bottom).offset(5)
            make.right.equalTo(self).offset(-10)
            make.width.equalTo(likeImageView)
            make.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(likeImageView.snp.left).offset(-10)
            make.height.greaterThanOrEqualTo(15)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(likeImageView.snp.left).offset(-10)
            make.height.equalTo(12)
        }
        
        createdLabel.snp.makeConstraints { make in
            make.top.equalTo(tagLabel.snp.bottom).offset(5)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(likeImageView.snp.left).offset(-10)
            make.height.equalTo(12)
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
