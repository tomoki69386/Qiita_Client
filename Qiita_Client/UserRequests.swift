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
    
    var isAPIHost: BaseURL { return .qiita }
    var requiresToken: Bool { return true }
    var path: String { return "/authenticated_user" }
    
    var parameters: [String : Any] { return [:]}
}

/// Userの投稿した記事を取得
struct UserArticleRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ArticleModel
    
    var isAPIHost: BaseURL { return .qiita }
    var requiresToken: Bool { return true }
    var path: String { return "/authenticated_user/items" }
    
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
    
    var isAPIHost: BaseURL { return .qiita }
    var requiresToken: Bool { return true}
    var path: String { return "/users/\(AppUser.id)/stocks" }
    
    let currentIndex: Int

    var parameters: [String : Any] {
        return [
            "page": "\(self.currentIndex)",
            "per_page": "20"
        ]
    }
}

/// Userのフォローを取得
struct UserFollowRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var isAPIHost: BaseURL { return .qiita }
    var requiresToken: Bool { return true }
    var path: String { return "/users/\(AppUser.id)/followees" }
    
    var parameters: [String : Any] { return [:]}
}

/// Userのフォロワーを取得
struct UserFollowerRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ProfileModel
    
    var isAPIHost: BaseURL { return .qiita }
    var requiresToken: Bool { return true }
    var path: String { return "/users/\(AppUser.id)/followers" }
    
    var parameters: [String : Any] { return [:]}
}
