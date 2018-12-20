//
//  Result.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/19.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

enum APIResult {
    case success
    case failure(Error, statusCode: Int?)
}
