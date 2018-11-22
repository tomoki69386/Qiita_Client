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
    
    static var accessToken: String? {
        return Defaults[.accessToken]
    }
    
    static var clientID: String? {
        return Defaults[.clientID]
    }
    
    static var clientSecret: String? {
        return Defaults[.clientSecret]
    }
    
    static func setUp(id: String, secret: String) {
        Defaults[.clientID] = id
        Defaults[.clientSecret] = secret
    }
}

private extension DefaultsKeys {
    static let accessToken = DefaultsKey<String?>("access_token", defaultValue: nil)
    static let clientID = DefaultsKey<String?>("client_id", defaultValue: nil)
    static let clientSecret = DefaultsKey<String?>("client_secret", defaultValue: nil)
}
