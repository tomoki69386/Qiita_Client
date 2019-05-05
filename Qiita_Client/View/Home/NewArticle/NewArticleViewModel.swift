//
//  NewArticleViewModel.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2019/05/03.
//  Copyright © 2019 tomoki. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewArticleViewModel {
    private let disposeBag = DisposeBag()
    var articles: [ArticleModel] { return _articles.value }
    private let _articles = BehaviorRelay<[ArticleModel]>(value: [])
    
    // observables
    let deselectRow: Observable<IndexPath>
    let reloadData: Observable<Void>
    let transitionToArticleDetail: Observable<ArticleModel>
    
    var page: Int = 1
    var isLoading = false
    var isComplete = false
    var preference: Bool?
    
    init(itemSelected: Observable<IndexPath>,
         model: NewArticleModelProtocol = NewArticleModel()) {

        self.deselectRow = itemSelected.map { $0 }
        self.reloadData = _articles.map { _ in }
        
        let fetchArticlesResponse = model
            .fetchNewArticle(with: page)
            .materialize()
        
        fetchArticlesResponse
            .flatMap { event -> Observable<[ArticleModel]> in
                event.element.map(Observable.just) ?? .empty()
            }
            .bind(to: _articles)
            .disposed(by: disposeBag)
        
        self.transitionToArticleDetail = itemSelected
            .withLatestFrom(_articles) { ($0, $1) }
            .flatMap { indexPath, articles -> Observable<ArticleModel> in
                guard indexPath.row < articles.count else {
                    return .empty()
                }
                return .just(articles[indexPath.row])
        }
    }
}
