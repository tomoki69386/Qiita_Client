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
    
    var isAPIHost: BaseURL { return .qiita }
    var isHeaders: Headers { return .uncertified }
    var path: String { return "/access_tokens" }
    
    let code: String
    
    var parameters: [String : Any] {
        return [
            "client_id": AppUser.clientID,
            "client_secret": AppUser.clientSecret,
            "code": code
        ]
    }
}
