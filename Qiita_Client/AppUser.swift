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
    
    static var accessToken: String {
        return Defaults[.accessToken]
    }
    
    static var clientID: String {
        return Defaults[.clientID]
    }
    
    static var clientSecret: String {
        return Defaults[.clientSecret]
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
}

private extension DefaultsKeys {
    static let accessToken = DefaultsKey<String>("access_token", defaultValue: "")
    static let clientID = DefaultsKey<String>("client_id", defaultValue: "")
    static let clientSecret = DefaultsKey<String>("client_secret", defaultValue: "")

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
