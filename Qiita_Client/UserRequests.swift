//
//  UserRequest.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

/// UserのProfileを取得
struct UserProfileRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserProfile }
    
    var parameters: [String : Any] { return [:]}
}

/// Userの投稿した記事を取得
struct UserArticleRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ArticleModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserArticle }
    
    let currentIndex: Int
    
    var parameters: [String: Any] {
        return [
            "page": "\(self.currentIndex)",
            "per_page": "20"
        ]
    }
}

/// UserがStockした記事を取得
struct UserStockArticleRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ArticleModel
    
    var requiresToken: Bool { return true}
    var endpoint: Endpoint { return .getUserStock}
    
    var parameters: [String : Any] { return [:]}
}

/// Userのフォローを取得
struct UserFollowRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserFollow}
    
    var parameters: [String : Any] { return [:]}
}

struct UserFollowerRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserFollower}
    
    var parameters: [String : Any] { return [:]}
}
