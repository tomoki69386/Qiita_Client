//
//  ArticleRequests.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct NewArticleRequest: GETRequest, DecodingRequest {
    
    typealias Decoded = ArticleModel
    
    var requiresToken: Bool { return true }
    var path: String { return "/items" }
    
    let currentIndex: Int
    
    var parameters: [String : Any] {
        return [
            "page": "\(self.currentIndex)",
            "per_page": "20"
        ]
    }
}

/// いいねしてるか取得
struct GetLikeRequest: GETRequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/like" }
    
    var parameters: [String : Any] { return [:] }
}

/// いいねする
struct PutLikeRequest: PUTRequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/like" }
    
    var parameters: [String : Any] { return [:] }
}

/// いいねを取り消す
struct DelegateLikeRequest: DELETERequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/like" }
    
    var parameters: [String : Any] { return [:] }
}

/// Stockしてるか取得
struct GetStockRequest: GETRequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/stock" }
    
    var parameters: [String : Any] { return [:] }
}

/// Stockする
struct PutStockRequest: PUTRequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/stock" }
    
    var parameters: [String : Any] { return [:] }
}

/// Stockを取り消す
struct DeleteStockRequest: DELETERequest {
    
    typealias Decoded = APIResult
    let id: String
    
    var requiresToken: Bool { return true }
    var path: String { return "/items/\(id)/stock" }
    
    var parameters: [String : Any] { return [:] }
}
