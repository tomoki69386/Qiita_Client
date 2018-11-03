//
//  items.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct Article: Codable {
    var title: String?
    var user: User
    
    struct User: Codable {
        var id: String?
    }
}