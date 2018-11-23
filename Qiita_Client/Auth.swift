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

        let headers = [
            "Content-type": "application/json",
            "ACCEPT": "application/json",
            "Authorization": "Bearer \(AppUser.accessToken)"
        ]
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON{ response in
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
}
