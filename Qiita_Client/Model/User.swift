//
//  User.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/09.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation

struct User: Codable {
    var description: String?
    var facebook_id: String?
    var followees_count: Int?
    var followers_count: Int?
    var github_login_name: String?
    var id: String?
    var items_count: Int?
    var linkedin_id: String?
    var location: String?
    var name: String?
    var organization: String?
    var permanent_id: Int?
    var profile_image_url: String?
    var twitter_screen_name: String?
    var website_url: String?
}
