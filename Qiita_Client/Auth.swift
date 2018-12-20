//
//  Auth.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/23.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation
import Alamofire

struct Auth {
    static func getUserProfile() {
        let url = "https://qiita.com/api/v2/authenticated_user"
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: APIClient.headers).responseJSON{ response in
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                let result = try! decoder.decode(User.self, from: response.data!)
                AppUser.saveUser(user: result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getAccessToken(code: String, onSuccess: @escaping (APIResult) -> Void) {
        let url = "https://qiita.com/api/v2/access_tokens"
        let parameters: Parameters = [
            "client_id": AppUser.clientID,
            "client_secret": AppUser.clientSecret,
            "code": code
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: APIClient.authHeaders).responseJSON{ response in
            let result: APIResult
            defer { onSuccess(result) }
            switch response.result {
            case .success:
                let decoder = JSONDecoder()
                let data = try! decoder.decode(AccessToken.self, from: response.data!)
                AppUser.saveAccessToken(token: data.token)
                result = .success
            case .failure(let error):
                print(error)
                result = .failure(error, statusCode: response.response?.statusCode)
            }
        }
    }
}
