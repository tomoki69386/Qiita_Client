//
//  items.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct Article: Codable {
    
    struct Tag: Codable {
        let name: String
        let versions: [String]
    }
    
    /// タグを特定するための一意な名前
    let id: String
    
    /// Markdown形式の本文
    let body: String
    
    /// データが作成された日時
    let createdAt: String
    
    /// 投稿のタイトル
    let title: String
    
    /// いいねの数
    let likesCount: Int
    
    /// 投稿のURL
    let URL: Foundation.URL
    
    /// 投稿者
    let user: User
    
}

extension Article {
    
    enum CodingKeys: String, CodingKey {
        case id           = "id"
        case body         = "body"
        case createdAt    = "created_at"
        case title        = "title"
        case likesCount   = "likes_count"
        case URL          = "url"
        case user         = "user"
    }
    
}
