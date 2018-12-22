//
//  FirstViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Alamofire

class FirstViewController: MainViewController {

    @IBOutlet private weak var registrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registrationButton.setTitle("ログイン", for: .normal)
        registrationButton.setTitleColor(AppColor.white, for: .normal)
        registrationButton.backgroundColor = AppColor.main
        registrationButton.layer.cornerRadius = registrationButton.frame.height / 2
        
        registrationButton.rx.tap.subscribe(onNext: { _ in
            Tracker.event(.login)
        }).disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Tracker.screenName(.lp)
    }
}
