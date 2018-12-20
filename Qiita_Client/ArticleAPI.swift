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
    static func fetchNewArticle(completion: @escaping (APIDecodingResult<[ArticleModel]>) -> Void) {
        let request = NewArticleRequest()
        APIClient.send(request, decodingCompletion: completion)
    }
}
