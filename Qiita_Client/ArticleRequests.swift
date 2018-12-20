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
    var endpoint: Endpoint { return .newArticle }
}
