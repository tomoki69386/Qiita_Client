//
//  BaseAPIProtocol.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/12.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

// MARK: - Base API Protocol
protocol BaseAPIProtocol {
    associatedtype ResponseType // レスポンスの型
    
    var method: HTTPMethod { get } // get,post,delete などなど
    var baseURL: URL { get } // APIの共通呼び出し元。 ex "https://~~~"
    var path: String { get } // リクエストごとのパス
    var headers: HTTPHeaders? { get } // ヘッダー情報
    
}

extension BaseAPIProtocol {
    
    var baseURL: URL { // 先ほど上で定義したもの。
        // 絶対にあることがある保証されているので「try！」を使用している
        return try! APIConstants.baseURL.asURL()
    }
    
    var headers: HTTPHeaders? { // 先ほど上で定義したもの。なければ「return nil」でok
        return nil
    }
}
