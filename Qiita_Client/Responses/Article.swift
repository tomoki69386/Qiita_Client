//
//  items.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

public struct Article: Codable {
    
    public struct Tag: Codable {
        let name: String
        let versions: [String]
    }
    
    /// タグを特定するための一意な名前
    public let id: String
    
    /// Markdown形式の本文
    public let body: String
    
    /// データが作成された日時
    public let createdAt: String
    
    /// 投稿のタイトル
    public let title: String
    
    /// 投稿のURL
    public let URL: Foundation.URL
    
    /// 投稿者
    public let user: User
    
}

extension Article {
    
    enum CodingKeys: String, CodingKey {
        case id           = "id"
        case body         = "body"
        case createdAt    = "created_at"
        case title        = "title"
        case URL          = "url"
        case user         = "user"
    }
    
}
