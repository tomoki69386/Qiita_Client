//
//  SafariViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/31.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SafariServices

extension SFSafariViewController {
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.preferredBarTintColor = AppColor.main
        self.preferredControlTintColor = AppColor.white
    }
}
