//
//  AppAPI.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct AppAPI {
    
    private init() {}
    
    /// AccessTokenを取得
    static func fetchAccessToken(code: String, completion: @escaping (APIDecodingResult<AccessTokenModel>) -> Void) {
        let request = AccessTokenRequest(code: code)
        APIClient.send(request, decodingCompletion: completion)
    }
}
