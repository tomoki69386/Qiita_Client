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
        let hostName = "https://qiita.com"
        return Endpoint(urlString: hostName)
    }()
    
    static let appVersion = Endpoint.apiHost + "/api/versions/"
    
    /// AccessTokenのUserを取得
    static let user = Endpoint.apiHost + "api/v2/authenticated_user"
    
    /// 新着記事取得
    static let newArticle = Endpoint.apiHost + "/api/v2/items?page=1&per_page=20"
}

