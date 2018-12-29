//
//  APIRequest.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

enum BaseURL {
    case qiita
    case slack
    
    var url: String {
        switch self {
        case .qiita:
            return "https://qiita.com/api/v2"
        case .slack:
            return "https://hooks.slack.com"
        }
    }
}

enum Headers {
    /// デフォルト
    case defaults
    
    /// 未認証時
    case uncertified
    
    /// headerなし
    case none
    
    var item: [String: String] {
        switch self {
        case .defaults:
            return [
                "Content-type": "application/json",
                "ACCEPT": "application/json",
                "Authorization": "Bearer \(AppUser.accessToken)"
            ]
        case .uncertified:
            return [
                "Content-type": "application/json",
                "ACCEPT": "application/json"
            ]
        case .none:
            return [:]
        }
    }
}

// MARK: - APIRequest -

protocol APIRequest {
    static var httpMethod: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var path: String { get }
    var isAPIHost: BaseURL { get }
    var isHeaders: Headers { get }
}

extension APIRequest {
    
    var defaultHeaders: [String: String] {
        return isHeaders.item
    }
    
    var headers: [String: String] { return self.defaultHeaders }
    var queryItems: [URLQueryItem]? { return nil }
    
    /// APIホスト
    var baseURL: URL {
        return URL(string: isAPIHost.url)!
    }
    
    /// Alamofireに渡すURLコンポーネント
    var urlComponents: URLComponents {
        guard var urlComponents = URLComponents(string: "\(self.baseURL)\(self.path)") else {
            print("Invalid Endpoint:", self.path)
            assertionFailure("\(self.path) は無効なURLです。\(Self.self)のエンドポイントを修正してください。")
            return URLComponents()
        }
        urlComponents.queryItems = self.queryItems
        return urlComponents
    }
    
}

protocol ParametersProvider {
    var parameters: [String: Any] { get }
}

// MARK: - GETRequest

protocol GETRequest: APIRequest, ParametersProvider {}

extension GETRequest {
    static var httpMethod: HTTPMethod { return .get }
}

// MARK: - POSTRequest

protocol POSTRequest: APIRequest, ParametersProvider {}

extension POSTRequest {
    static var httpMethod: HTTPMethod { return .post }
}

// MARK: - PUTRequest

protocol PUTRequest: APIRequest, ParametersProvider {}

extension PUTRequest {
    static var httpMethod: HTTPMethod { return .put }
}

// MARK: - DELETERequest

protocol DELETERequest: APIRequest, ParametersProvider {}

extension DELETERequest {
    static var httpMethod: HTTPMethod { return .delete }
}

// MARK: - DecodingRequest

protocol DecodingRequest: APIRequest {
    associatedtype Decoded: Decodable
}



