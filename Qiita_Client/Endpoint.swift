//
//  Endpoint.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

extension Endpoint {
    
    static let apiHost: Endpoint = {
        let hostName = "https://qiita.com/api/v2"
        return Endpoint(urlString: hostName)
    }()
    
    /// UserProfileを取得
    static let getUserProfile = Endpoint.apiHost + "/authenticated_user"
    
    /// Userの投稿した記事を取得
    static let getUserArticle = Endpoint.apiHost + "/authenticated_user/items"
    
    /// UserがStockした記事を取得
    static let getUserStock = Endpoint.apiHost + "/users/\(AppUser.id)/stocks?page=1&per_page=20"
    
    /// UserのFollowを取得
    static let getUserFollow = Endpoint.apiHost + "/users/\(AppUser.id)/followees"
    
    /// UserのFollowerを取得
    static let getUserFollower = Endpoint.apiHost + "/users/\(AppUser.id)/followers"
    
    /// 新着記事取得
    static let newArticle = Endpoint.apiHost + "/items?page=1&per_page=20"
}

