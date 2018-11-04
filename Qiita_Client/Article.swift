//
//  items.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct Article: Codable {
    var title: String?
    var url: String?
    var userId: String?
    
    private enum UserKeys: String, CodingKey {
        case userId = "id"
    }
    
    private enum ArticleKeys: String, CodingKey {
        case title
        case url
        case user
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ArticleKeys.self)
        self.title = try values.decode(String.self, forKey: .title)
        self.url = try values.decode(String.self, forKey: .url)
        let user = try values.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        self.userId = try user.decode(String.self, forKey: .userId)
    }
}
