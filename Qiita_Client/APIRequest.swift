//
//  APIRequest.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

// MARK: - Endpoint -

struct Endpoint {
    
    let urlString: String
    
    static func +(lhs: Endpoint, path: String) -> Endpoint {
        return Endpoint(urlString: lhs.urlString + path)
    }
    
}

// MARK: - APIRequest -

protocol APIRequest {
    static var httpMethod: HTTPMethod { get }
    var requiresToken: Bool { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var endpoint: Endpoint { get }
}

extension APIRequest {
    
    var defaultHeaders: [String: String] {
        guard self.requiresToken else { return [:] }
        return [
            "Content-type": "application/json",
            "ACCEPT": "application/json",
            "Authorization": "Bearer \(AppUser.accessToken)"
        ]
    }
    
    var headers: [String: String] { return self.defaultHeaders }
    var queryItems: [URLQueryItem]? { return nil }
    
    /// Alamofireに渡すURLコンポーネント
    var urlComponents: URLComponents {
        guard var urlComponents = URLComponents(string: self.endpoint.urlString) else {
            print("Invalid Endpoint:", self.endpoint.urlString)
            assertionFailure("\(self.endpoint.urlString) は無効なURLです。\(Self.self)のエンドポイントを修正してください。")
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

protocol GETRequest: APIRequest {}

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

// MARK: - DecodingRequest

protocol DecodingRequest: APIRequest {
    associatedtype Decoded: Decodable
}

protocol PageableRequestType: APIRequest {
    
    /// ページ番号 (1から100まで)
    var page: Int { get set }
    
    /// 1ページあたりに含まれる要素数 (1から100まで)
    var perPage: Int { get set }
    
}

extension PageableRequestType {
    
    /// ページング用パラメータ
    var pageParamaters: [String: String] {
        return [
            "page"     : "\(page)",
            "per_page" : "\(perPage)"
        ]
    }
    
}



