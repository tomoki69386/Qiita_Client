//
//  PopUp.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/31.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

struct PopUp {
    
    private var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
    
    func topMessage(text: String) {
        guard  let vc = topViewController else { return }
        
        let baseView = UIButton()
        baseView.backgroundColor = AppColor.white
        baseView.layer.cornerRadius = 10
        vc.view.addSubview(baseView)
        
        baseView.frame = CGRect(x: 10, y: -80, width: vc.view.frame.width - 20, height: 80)
        
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        baseView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.left.equalTo(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            baseView.frame.origin.y = 5
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.animate(withDuration: 0.6, animations: {
                    baseView.frame.origin.y = -80
                }) { _ in
                    baseView.removeFromSuperview()
                    label.removeFromSuperview()
                }
            }
        }
    }
    
}
