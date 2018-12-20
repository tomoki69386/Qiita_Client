//
//  UserRequest.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct UserProfileRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserProfile }
    
}
