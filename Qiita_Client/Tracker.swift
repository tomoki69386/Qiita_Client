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
    
    static func screenName(_ log: Log) {
        if !Device.isSimulator() {
            Flurry.logEvent(log.screenName)
        }
    }
    
    static func event(_ log: Event) {
        if !Device.isSimulator() {
            Flurry.logEvent(log.log)
        }
    }
    
    static func setUserID() {
        if !Device.isSimulator() {
            if AppUser.deviceID == "" {
                AppUser.saveDeviceUUID((UIDevice.current.identifierForVendor?.uuidString)!)
            }
            Flurry.setUserID(AppUser.deviceID)
        }
    }
}

enum Event {
    /// いいね
    case like
    
    /// ストック
    case stock
    
    /// ログイン
    case login
    
    var log: String {
        switch self {
        case .like:
            return "いいね"
        case .stock:
            return "ストック"
        case .login:
            return "ログイン"
        }
    }
}

enum Log {
    /// 記事詳細画面
    case readArticle
    
    /// 記事一覧画面
    case articleList
    
    ///検索画面
    case search
    
    ///設定画面
    case setting
    
    ///Myページ
    case myPage
    
    ///ログアウト
    case logout
    
    ///お問い合わせ
    case info
    
    ///利用規約
    case service
    
    ///プライバシーポリシー
    case privacy
    
    ///ライセンス
    case license
    
    /// LP画面
    case lp
    
    /// 認証画面
    case auth
    
    var screenName: String {
        switch self {
        case .readArticle:
            return "記事詳細画面"
        case .articleList:
            return "記事一覧画面"
        case .search:
            return "検索画面"
        case .setting:
            return "設定画面"
        case .myPage:
            return "Myページ"
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
        case .lp:
            return "LP画面"
        case .auth:
            return "認証画面"
        }
    }
}
