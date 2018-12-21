//
//  AppRequest.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct AccessTokenRequest: POSTRequest, DecodingRequest {
    
    typealias Decoded = AccessTokenModel
    
    var requiresToken: Bool { return false }
    var path: String { return "/access_token" }
    
    let code: String
    
    var parameters: [String : Any] {
        return [
            "client_id": AppUser.clientID,
            "client_secret": AppUser.clientSecret,
            "code": code
        ]
    }
}
