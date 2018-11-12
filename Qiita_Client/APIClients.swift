//
//  APIClients.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/12.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

enum APIConstants {
    case article
    case userArticle
    case user
    
    // MARK: Public Variables
    public var path: String {
        switch self {
        case .article: return "api/v2/items?page=1&per_page=20"
        case .userArticle: return "api/v2/users/tomoki_sun/items?page=1&per_page=20"
        case .user: return "api/v2/users/tomoki_sun"
        }
    }
    
    
    // MARK: Public Static Variables
    public static var baseURL = "https://qiita.com/"
    
    public static var header: HTTPHeaders? {
        // 必要ならば個々に設定してください
//        return [
//            "Accept-Encoding": ~~~,
//            "Accept-Language": ~~~,
//            "User-Agent": "~~~~"
//        ]
        return [:]
    }
}
