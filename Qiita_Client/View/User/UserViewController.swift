//
//  UserViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/04.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import SkeletonView

class UserViewController: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var ImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        label.numberOfLines = 0
        label.isSkeletonable = true
        view.showAnimatedGradientSkeleton()
    }

}
