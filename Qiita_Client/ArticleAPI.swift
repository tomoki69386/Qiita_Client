//
//  ArticleAPI.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct ArticleAPI {
    
    private init() {}

    /// 新着記事の取得
    static func fetchNewArticle(in index: Int, completion: @escaping (APIDecodingResult<[ArticleModel]>) -> Void) {
        let request = NewArticleRequest(currentIndex: index)
        APIClient.send(request, decodingCompletion: completion)
    }
    
    /// 検索
    static func fetchSearchArticle(text: String, completion: @escaping (APIDecodingResult<[ArticleModel]>) -> Void) {
        let request = SearchArticleRequest(text: text)
        APIClient.send(request, decodingCompletion: completion)
    }
    
    /// Likeしてるか取得
    static func getLike(id: String, completion: @escaping (APIResult) -> Void) {
        let request = GetLikeRequest(id: id)
        APIClient.send(request, completion: completion)
    }
    
    /// Likeする
    static func putLike(id: String, completion: @escaping (APIResult) -> Void) {
        let request = PutLikeRequest(id: id)
        APIClient.send(request, completion: completion)
    }
    
    /// Likeを取り消す
    static func deleteLike(id: String, completion: @escaping (APIResult) -> Void) {
        let request = DelegateLikeRequest(id: id)
        APIClient.send(request, completion: completion)
    }

    /// Stockしてるか取得
    static func getStock(id: String, completion: @escaping (APIResult) -> Void) {
        let request = GetStockRequest(id: id)
        APIClient.send(request, completion: completion)
    }
    
    /// Stockする
    static func putStock(id: String, completion: @escaping (APIResult) -> Void) {
        let request = PutStockRequest(id: id)
        APIClient.send(request, completion: completion)
    }
    /// Stockを取り消す
    static func deleteStock(id: String, completion: @escaping (APIResult) -> Void) {
        let request = DeleteStockRequest(id: id)
        APIClient.send(request, completion: completion)
    }
}
