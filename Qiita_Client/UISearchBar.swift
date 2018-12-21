//
//  UISearchBar.swift
//  Qiita_Client
//
//  Created by 築山朋紀 on 2018/12/21.
//  Copyright © 2018 tomoki. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField? {
        return value(forKey: "_searchField") as? UITextField
    }
}
