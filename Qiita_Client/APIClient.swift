//
//  APIClient.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Alamofire

struct APIClient {
    
    private init() {}
    
    /// responseが帰ってこないとき
    static func send<Request: APIRequest>(_ request: Request,
                                          preprocessOnSuccess: @escaping () -> Void = {},
                                          completion: @escaping (APIResult) -> Void) {
        request.alamofireRequest
            .responseString { response in
                let result: APIResult
                defer { completion(result) }
                
                switch response.result {
                case .success(let string):
                    debugPrint(string)
                    preprocessOnSuccess()
                    result = .success
                case .failure(let error):
                    printFailedResponse(response, or: error)
                    result = .failure(error, statusCode: response.response?.statusCode)
                }
        }
    }
    
    /// responseが配列の時
    static func send<Request: DecodingRequest>(_ request: Request,
                                               decodingCompletion: @escaping (APIDecodingResult<[Request.Decoded]>) -> Void) {
        request.alamofireRequest
            .responseJSON { response in
                let result: APIDecodingResult<[Request.Decoded]>
                defer { decodingCompletion(result) }
                
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        assertionFailure("response.resultがsuccessならresponse.dataはnilでないはず")
                        result = .failure(NSError(), statusCode: statusCode)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode([Request.Decoded].self, from: data)
                        result = .success(decoded)
                    } catch {
                        print("ERROR:", "\(type(of: Request.Decoded.self))型へのデコードに失敗しました")
                        debugPrint(error)
                        result = .failure(error, statusCode: statusCode)
                    }
                case .failure(let error):
                    print("ERROR:", "\(type(of: Request.Decoded.self))型へ変換するJSONが取得できませんでした")
                    printFailedResponse(response, or: error)
                    result = .failure(error, statusCode: statusCode)
                }
        }
    }
    
    /// responseが一つの時
    static func send<Request: DecodingRequest>(_ request: Request,
                                               decodingCompletion: @escaping (APIDecodingResult<Request.Decoded>) -> Void) {
        request.alamofireRequest
            .responseJSON { response in
                let result: APIDecodingResult<Request.Decoded>
                defer { decodingCompletion(result) }
                
                let statusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        assertionFailure("response.resultがsuccessならresponse.dataはnilでないはず")
                        result = .failure(NSError(), statusCode: statusCode)
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        let decoded = try decoder.decode(Request.Decoded.self, from: data)
                        result = .success(decoded)
                    } catch {
                        print("ERROR:", "\(type(of: Request.Decoded.self))型へのデコードに失敗しました")
                        debugPrint(error)
                        result = .failure(error, statusCode: statusCode)
                    }
                case .failure(let error):
                    print("ERROR:", "\(type(of: Request.Decoded.self))型へ変換するJSONが取得できませんでした")
                    printFailedResponse(response, or: error)
                    result = .failure(error, statusCode: statusCode)
                }
        }
    }
    
    /// 失敗時のレスポンス内容があれば出力し、なければエラーを出力する
    private static func printFailedResponse<T>(_ response: DataResponse<T>, or error: Error) {
        if let data = response.data, let responseString = String(data: data, encoding: .utf8), !responseString.isEmpty {
            print("エラー内容:", responseString)
        } else {
            debugPrint(error)
        }
    }
    
}

private extension APIRequest {
    
    var alamofireRequest: DataRequest {
        return Alamofire.request(self.urlComponents,
                                 method: Self.httpMethod,
                                 parameters: (self as? ParametersProvider)?.parameters,
                                 encoding: JSONEncoding.default,
                                 headers: self.headers)
            .validate(statusCode: 200..<300)
    }
    
}

