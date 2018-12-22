//
//  AppDelegate.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/03.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Device
import Flurry_iOS_SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = AppColor.main
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UITabBar.appearance().tintColor = AppColor.white
        UITabBar.appearance().backgroundColor = AppColor.white
        
        // .envの読み込み
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError(".envファイルがプロジェクトファイルに存在しません。")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy:"\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy:"=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
        
        guard let clientID = ProcessInfo.processInfo.environment["Client_id"] else {
            fatalError("Client_idが.envファイルに記載されていません。")
        }
        guard let clientSecret = ProcessInfo.processInfo.environment["Client_Secret"] else {
            fatalError("Client_Secretが.envファイルに記載されていません。")
        }
        guard let FlurryAPIKey = ProcessInfo.processInfo.environment["Flurry_API_Key"] else {
            fatalError("Flurry_API_Keyが.envファイルに記載されていません。")
        }
        
        guard let slackURL = ProcessInfo.processInfo.environment["Slack_URL"] else {
            fatalError("Slack_URLが.envファイルに記載されていません。")
        }
        AppUser.setUp(id: clientID, secret: clientSecret, url: slackURL)
        
        // Flurryの初期設定
        Flurry.startSession(FlurryAPIKey, with: FlurrySessionBuilder
            .init()
            .withCrashReporting(true)
            .withLogLevel(FlurryLogLevelAll))
        Tracker.setUserID()
        
        // ログイン判定
        if AppUser.accessToken != "" {
            self.window?.rootViewController = Storyboard.tabBar.instantiateViewController()
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

