//
//  InfoViewController.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/11/22.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit
import Device
import Alamofire

class InfoViewController: MainViewController {
    
    @IBOutlet private weak var nameInputField: UITextField!
    @IBOutlet private weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setSwipeBack()
        navigationItem.title = "お問い合わせ"
        nameInputField.delegate = self
        nameInputField.becomeFirstResponder()
        let barButton = UIBarButtonItem(title: "送信", style: .done, target: self, action: #selector(InfoViewController.send))
        barButton.tintColor = AppColor.white
        barButton.isEnabled = false
        navigationItem.setRightBarButtonItems([barButton], animated: true)
        
        textView.rx.text.asDriver().drive(onNext: { outPutText in
            guard let text = outPutText else { return }
            if text.count == 0 {
                barButton.isEnabled = false
            } else {
                barButton.isEnabled = true
            }
        }).disposed(by: self.disposeBag)
    }
    
    @objc func send() {
        nameInputField.resignFirstResponder()
        textView.resignFirstResponder()
        guard let name = nameInputField.text else { return }
        guard let message = textView.text else { return }
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        
        let text = """
        時間: \(Date())
        端末名: \(Device.version())
        アプリバージョン: \(version)
        名前: \(name)
        お問い合わせ内容:
        \(message)
        """
        let parameters: [String: Any] = [
            "text": text
        ]
        
        AppAPI.fetchSlackMessage(parameter: parameters) { (result) in
            switch result {
            case .success:
                print("succcess")
            case .failure(let error, _):
                print(error)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension InfoViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.becomeFirstResponder()
        return true
    }
}
