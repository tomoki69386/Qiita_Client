//
//  APIClient.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct APIClient {
    
    static func fetchArticle(_ completion: @escaping ([Article]) -> Void) {
        let components = URLComponents(string: "https://qiita.com/api/v2/items")
        guard let url = components?.url else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let decorder = JSONDecoder()
            do {
                let articles = try decorder.decode([Article].self, from: data)
                completion(articles)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
