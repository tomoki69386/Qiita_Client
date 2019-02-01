//
//  Swipe.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/01.
//  Copyright © 2018 tomoki. All rights reserved.
//

import Foundation
import UIKit

protocol SwipeBackable {
    func setSwipeBack()
}

extension SwipeBackable where Self: UIViewController {
    func setSwipeBack() {
        let target = self.navigationController?.value(forKey: "_cachedInteractionController")
        let recognizer = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        self.view.addGestureRecognizer(recognizer)
    }
}
