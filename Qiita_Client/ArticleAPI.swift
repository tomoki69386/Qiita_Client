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
    
    /// Likeしてるか取得
    static func fetchArticleLike(id: String, completion: @escaping (APIResult) -> Void) {
        let request = GetLikeRequest(id: id)
        APIClient.send(request, completion: completion)
    }
    
    static func fetchArticleStock(id: String, completion: @escaping (APIResult) -> Void) {
        let request = GetStockRequest(id: id)
        APIClient.send(request, completion: completion)
    }
}
