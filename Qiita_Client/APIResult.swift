//
//  APIResult.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/12.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

enum APIResult {
    case success(Codable)
    case failure(Error)
}

// MARK: - ErrorResponse
// 自分でデコードのエラーだとわかるならなんでもいいです。
struct ErrorResponse: Error, CustomStringConvertible {
    let description: String = "-- Decode Error --"
    var dataContents: String?
}
