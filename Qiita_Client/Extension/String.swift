//
//  String.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

public extension String {
    public var url: URL? {
        return URL(string: self)
    }
}

extension URL: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        guard let url = URL(string: value) else {
            fatalError("\(value) is an invalid url")
        }
        self = url
    }
    
    public init(extendedGraphemeClusterLiteral value: String) {
        self.init(stringLiteral: value)
    }
    
    public init(unicodeScalarLiteral value: String) {
        self.init(stringLiteral: value)
    }
}
