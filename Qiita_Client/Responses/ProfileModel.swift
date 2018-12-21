//
//  ProfileModel.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/09.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

public struct ProfileModel: Codable {
    
    /// 自己紹介文
    public let userDescription: String?
    
    /// Facebook ID
    public let facebookID: String?
    
    //// フォローしているユーザの数
    public let followeesCount: Int
    
    /// フォローしているユーザの数
    public let followersCount: Int
    
    /// GitHub ID
    public let githubLoginName: String?
    
    /// ユーザID
    public let id: String
    
    /// このユーザが qiita.com 上で公開している投稿の数
    public let itemsCount: Int
    
    /// LinkedIn ID
    public let linkedinID: String?
    
    /// 居住地
    public let location: String?
    
    /// 名前
    public let name: String?
    
    /// 所属組織
    public let organization: String?
    
    /// ユーザごとに割り当てられる整数のID
    public let permanentID: Int
    
    /// プロフィール画像
    public let profileImageURL: String
    
    /// Twitter
    public let twitterScreenName: String?
    
    /// WebサイトのURL
    public let websiteURL: String?
}

extension ProfileModel {
    
    enum CodingKeys: String, CodingKey {
        case id                = "id"
        case followeesCount    = "followees_count"
        case followersCount    = "followers_count"
        case itemsCount        = "items_count"
        case permanentID       = "permanent_id"
        case profileImageURL   = "profile_image_url"
        case userDescription   = "description"
        case facebookID        = "facebook_id"
        case githubLoginName   = "github_login_name"
        case linkedinID        = "linkedin_id"
        case location          = "location"
        case name              = "name"
        case organization      = "organization"
        case twitterScreenName = "twitter_screen_name"
        case websiteURL        = "website_url"
    }
}
