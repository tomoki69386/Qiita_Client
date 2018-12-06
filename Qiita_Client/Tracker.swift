//
//  Tracker.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/06.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Device
import Flurry_iOS_SDK

struct Tracker {
    static func event(_ log: Log) {
        /// シミュレーターじゃないときにevent送信
        if !Device.isSimulator() {
            Flurry.logEvent(log.eventName)
        }
    }
}

enum Log {
    case readArticle
    case articleList
    case setting
    case myPage
    case myArticle
    case myStock
    case logout
    case info
    case service
    case privacy
    case license
    
    var eventName: String {
        switch self {
        case .readArticle:
            return "記事詳細画面"
        case .articleList:
            return "記事一覧画面"
        case .setting:
            return "設定画面"
        case .myPage:
            return "Myページ"
        case .myArticle:
            return "投稿一覧画面"
        case .myStock:
            return "ストック一覧画面"
        case .logout:
            return "ログアウト"
        case .info:
            return "お問い合わせ"
        case .service:
            return "利用規約"
        case .privacy:
            return "プライバシーポリシー"
        case .license:
            return "ライセンス"
        }
    }
}
