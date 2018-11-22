//
//  UserShowTableViewCell.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift

class UserShowTableViewCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColor.glay
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1.0
        button.layer.borderColor = AppColor.main.cgColor
        button.setTitle("フォローする", for: .normal)
        button.setTitle("フォロー中", for: .selected)
        button.setTitleColor(AppColor.main, for: .normal)
        button.setTitleColor(AppColor.white, for: .selected)
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let IDLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.glay
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private func selectButtonPush() {
        selectButton.rx.tap.subscribe( onNext: { _ in
            self.selectButton.isSelected = !self.selectButton.isSelected
            if self.selectButton.isSelected {
                self.selectButton.backgroundColor = AppColor.main
            } else {
                self.selectButton.backgroundColor = AppColor.white
            }
        }).disposed(by: disposeBag)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectButtonPush()
        
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
        self.addSubview(selectButton)
        self.addSubview(IDLabel)
    }
    
    func setUp() {
        selectButton.isSelected = false
        let imageURL = URL(string: "https://qiita-image-store.s3.amazonaws.com/0/165815/profile-images/1518552294")
        userImageView.sd_setImage(with: imageURL)
        nameLabel.text = "ともき"
        IDLabel.text = "@" + "tomoki_sun"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        userImageView.snp.makeConstraints { make in
            make.top.left.equalTo(self).offset(10)
            make.width.height.equalTo(40)
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(35)
            make.width.equalTo(self).dividedBy(3)
            selectButton.layer.cornerRadius = selectButton.frame.height / 2
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(selectButton.snp.left).offset(-5)
            make.height.equalTo(20)
        }
        
        IDLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(10)
            make.right.equalTo(selectButton.snp.left).offset(-5)
            make.height.equalTo(20)
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
