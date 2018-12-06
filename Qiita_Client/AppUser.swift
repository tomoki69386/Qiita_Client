//
//  AppUser.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import SwiftyUserDefaults

struct AppUser {
    private init() {}
    
    /// ログイン中のユーザーのアクセストークン
    static var accessToken: String {
        return Defaults[.accessToken]
    }
    
    /// APIKey
    static var clientID: String {
        return Defaults[.clientID]
    }
    
    /// APISecret
    static var clientSecret: String {
        return Defaults[.clientSecret]
    }
    
    /// デバイスUUID
    static var deviceID: String {
        return Defaults[.deviceID]
    }
    
    /// ユーザーID
    static var id: String {
        return Defaults[.id]
    }
    
    /// フォローしているユーザーの数
    static var followeesCount: Int {
        return Defaults[.followeesCount]
    }
    
    /// 自分のことをフォローしてるユーザーの数
    static var followersCount: Int {
        return Defaults[.followersCount]
    }
    
    /// このユーザーが公開している投稿の数
    static var itemsCount: Int {
        return Defaults[.itemsCount]
    }
    
    /// ユーザー毎に割り当てられる整数のID
    static var permanentID: Int {
        return Defaults[.permanentID]
    }
    
    /// プロフィール画像
    static var profileImageURL: String {
        return Defaults[.profileImageURL]
    }
    
    /// 自己紹介文
    static var userDescription: String? {
        return Defaults[.userDescription]
    }
    
    /// FacebookID
    static var facebookID: String? {
        return Defaults[.facebookID]
    }
    
    /// GitHubID
    static var githubLoginName: String? {
        return Defaults[.githubLoginName]
    }
    
    /// LinkedInID
    static var linkedinID: String? {
        return Defaults[.linkedinID]
    }
    
    /// 居住地
    static var location: String? {
        return Defaults[.location]
    }
    
    /// 名前
    static var name: String? {
        return Defaults[.name]
    }
    
    /// 所属組織
    static var organization: String? {
        return Defaults[.organization]
    }
    
    /// TwitterID
    static var twitterScreenName: String? {
        return Defaults[.twitterScreenName]
    }
    
    /// WebサイトのURL
    static var websiteURL: String? {
        return Defaults[.websiteURL]
    }
}

extension AppUser {
    static func setUp(id: String, secret: String) {
        Defaults[.clientID] = id
        Defaults[.clientSecret] = secret
    }
    
    static func saveAccessToken(token: String) {
        Defaults[.accessToken] = token
    }
    
    static func  saveDeviceUUID(_ id: String) {
        Defaults[.deviceID] = id
    }
    
    static func saveUser(user: User) {
        Defaults[.id] = user.id
        Defaults[.followeesCount] = user.followeesCount
        Defaults[.followersCount] = user.followersCount
        Defaults[.itemsCount] = user.itemsCount
        Defaults[.permanentID] = user.permanentID
        Defaults[.profileImageURL] = user.profileImageURL
        Defaults[.userDescription] = user.userDescription
        Defaults[.facebookID] = user.facebookID
        Defaults[.githubLoginName] = user.githubLoginName
        Defaults[.linkedinID] = user.linkedinID
        Defaults[.location] = user.location
        Defaults[.name] = user.name
        Defaults[.organization] = user.organization
        Defaults[.twitterScreenName] = user.twitterScreenName
        Defaults[.websiteURL] = user.websiteURL
    }
    
    /// ログアウトするときにデータをすべて削除します。
    static func logout() {
        Defaults.remove(.accessToken)
        
        Defaults.remove(.id)
        Defaults.remove(.followeesCount)
        Defaults.remove(.followersCount)
        Defaults.remove(.itemsCount)
        Defaults.remove(.permanentID)
        Defaults.remove(.profileImageURL)
        Defaults.remove(.userDescription)
        Defaults.remove(.facebookID)
        Defaults.remove(.githubLoginName)
        Defaults.remove(.linkedinID)
        Defaults.remove(.location)
        Defaults.remove(.name)
        Defaults.remove(.organization)
        Defaults.remove(.twitterScreenName)
        Defaults.remove(.websiteURL)
    }
}

private extension DefaultsKeys {
    static let accessToken = DefaultsKey<String>("access_token", defaultValue: "")
    static let clientID = DefaultsKey<String>("client_id", defaultValue: "")
    static let clientSecret = DefaultsKey<String>("client_secret", defaultValue: "")
    static let deviceID = DefaultsKey<String>("Device_UUID")

    static let id = DefaultsKey<String>("id")
    static let followeesCount = DefaultsKey<Int>("followees_count")
    static let followersCount = DefaultsKey<Int>("followers_count")
    static let itemsCount = DefaultsKey<Int>("items_count")
    static let permanentID = DefaultsKey<Int>("permanent_id")
    static let profileImageURL = DefaultsKey<String>("profile_image_url")
    static let userDescription = DefaultsKey<String?>("description", defaultValue: "")
    static let facebookID = DefaultsKey<String?>("facebook_id", defaultValue: "")
    static let githubLoginName = DefaultsKey<String?>("github_login_name", defaultValue: "")
    static let linkedinID = DefaultsKey<String?>("linkedin_id", defaultValue: "")
    static let location = DefaultsKey<String?>("location", defaultValue: "")
    static let name = DefaultsKey<String?>("name", defaultValue: "")
    static let organization = DefaultsKey<String?>("organization", defaultValue: "")
    static let twitterScreenName = DefaultsKey<String?>("twitter_screen_name", defaultValue: "")
    static let websiteURL = DefaultsKey<String?>("website_url", defaultValue: "")
}
