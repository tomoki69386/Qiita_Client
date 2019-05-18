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
    var items: Driver<[ArticleModel]> = .empty()
    
    let scrollViewReachedBottomSubject = PublishSubject<Void>()
    var scrollViewReachedBottom: Driver<Void> {
        return scrollViewReachedBottomSubject.asDriver(onErrorDriveWith: .empty())
    }
    
    let refreshTriggerSubject = PublishSubject<Void>()
    var refreshTrigger: Driver<Void> {
        return refreshTriggerSubject.asDriver(onErrorJustReturn: ())
    }
    
    private let errorSubject = PublishSubject<Error>()
    var errors: Driver<Error> {
        return errorSubject.asDriver(onErrorDriveWith: .empty())
    }
    
    private let loadedFirstDataSubject = PublishSubject<Void>()
    var loadedFirstData: Driver<Void> {
        return loadedFirstDataSubject.asDriver(onErrorJustReturn: ())
    }
    
    // observables
    let deselectRow: Observable<IndexPath>
    let reloadData: Observable<Void>
    let transitionToArticleDetail: Observable<ArticleModel>
    
    var page: Int = 1
    var isLoading = false
    var isComplete = false
    var isFirstLoad = true
    var preference: Bool?
    
    init(itemSelected: Observable<IndexPath>,
         model: NewArticleModelProtocol = NewArticleModel()) {

        self.deselectRow = itemSelected.map { $0 }
        self.reloadData = items.asObservable().map { _ in }
        
        self.transitionToArticleDetail = itemSelected
            .withLatestFrom(items) { ($0, $1) }
            .flatMap { indexPath, articles -> Observable<ArticleModel> in
                guard indexPath.row < articles.count else {
                    return .empty()
                }
                return .just(articles[indexPath.row])
        }
        
        let shouldRequestNextData: Observable<Void> = scrollViewReachedBottom
            .asObservable()
            .flatMapFirst { _ in return Observable<Void>.just(()) }
        
        let shouldRequestFirstData: Observable<Void> = refreshTrigger.do(onNext: { [weak self] _ in
            self?.page = 1
            self?.isComplete = false
            self?.isFirstLoad = true
        }).asObservable()
        
        self.items = Observable.of(
            shouldRequestNextData,
            shouldRequestFirstData
        )
        .merge()
            .flatMapFirst { [weak self] _ -> Observable<[ArticleModel]> in
                guard let me = self else { return .empty() }
                if me.isLoading {
                    return .empty()
                }
                me.isLoading = true
                
                return model.fetchNewArticle(with: me.page)
                .asObservable()
                    .do(onNext: { response in
                        if me.isFirstLoad {
                            me.loadedFirstDataSubject.onNext(())
                        }
                        me.page += 1
                        me.isLoading = false
                    })
                    .catchError({ [weak self] error in
                        self?.errorSubject.onNext(error)
                        return .empty()
                    })
        }
        .asDriver(onErrorDriveWith: .empty())
        .startWith([])
    }
}
