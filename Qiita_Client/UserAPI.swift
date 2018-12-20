//
//  UserAPI.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct UserAPI {
    
    private init() {}
    
    /// Userのプロフィール取得
    static func fetchProfile(completion: @escaping (APIDecodingResult<ProfileModel>) -> Void) {
        let request = UserProfileRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
}
