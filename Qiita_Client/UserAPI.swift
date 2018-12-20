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
    
    /// Userの投稿した記事を取得
    static func fetchUserArticle(completion: @escaping (APIDecodingResult<[ArticleModel]>) -> Void) {
        let request = UserArticleRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
    
    /// UserがStockした記事を取得
    static func fetchUserStockArticle(completion: @escaping (APIDecodingResult<[ArticleModel]>) -> Void) {
        let request = UserStockArticleRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
    
    /// Userのフォローを取得
    static func fetchUserFollow(completion: @escaping (APIDecodingResult<[ProfileModel]>) -> Void) {
        let request = UserFollowRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
    
    /// Userのフォロワーを取得
    static func fetchUserFollower(completion: @escaping (APIDecodingResult<[ProfileModel]>) -> Void) {
        let request = UserFollowerRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
}
