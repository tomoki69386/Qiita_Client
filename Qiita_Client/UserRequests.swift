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
}

/// Userの投稿した記事を取得
struct UserArticleRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ArticleModel
    
    var requiresToken: Bool { return true }
    var endpoint: Endpoint { return .getUserArticle }
    
}
