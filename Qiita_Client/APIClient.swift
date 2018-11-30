//
//  APIClient.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/23.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct APIClient {
    
    static let authHeaders: [String: String] = [
        "Content-type": "application/json",
        "ACCEPT": "application/json"
    ]

    static let headers: [String: String] = [
        "Content-type": "application/json",
        "ACCEPT": "application/json",
        "Authorization": "Bearer \(AppUser.accessToken)"
    ]
}
