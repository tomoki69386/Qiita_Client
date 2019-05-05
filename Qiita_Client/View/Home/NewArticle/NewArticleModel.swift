//
//  NewArticleModel.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2019/05/03.
//  Copyright © 2019 tomoki. All rights reserved.
//

import Foundation
import RxSwift

protocol NewArticleModelProtocol {
    func fetchNewArticle(with page: Int) -> Observable<[ArticleModel]>
}

final class NewArticleModel: NewArticleModelProtocol {
    func fetchNewArticle(with page: Int) -> Observable<[ArticleModel]> {
        return Observable.create { observable in
            ArticleAPI.fetchNewArticle(in: page, completion: { result in
                switch result {
                case .success(let decoded):
                    observable.onNext(decoded)
                    observable.onCompleted()
                case .failure(let error, _):
                    observable.onError(error)
                }
            })
            return Disposables.create()
        }
    }
}
