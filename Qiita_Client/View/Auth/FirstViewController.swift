//
//  FirstViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: UIViewController {

    @IBOutlet private weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registrationButton.setTitle("ログイン", for: .normal)
        registrationButton.setTitleColor(AppColor.white, for: .normal)
        registrationButton.backgroundColor = AppColor.main
        registrationButton.layer.cornerRadius = registrationButton.frame.height / 2
    }
}
