//
//  UserArticle.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/12.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

enum UserArticleRequest: BaseRequestProtocol {
    typealias ResponseType = Article
    
    case get
    
    var method: HTTPMethod {
        switch self {
        case .get: return .get
        }
    }
    
    var path: String {
        return APIConstants.userArticle.path
    }
    
    // サーバーになにか送る必要がある場合は、こちらでセットする
    var parameters: Parameters? {
        return nil
    }
    
}
