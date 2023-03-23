//
//  UISearchBar+Extensions.swift
//  Alfa-SelfCare
//
//  Created by Mojtaba Al Moussawi on 5/17/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
    }
    
    func setSearchIcon(image: UIImage) {
        setImage(image, for: .search, state: .normal)
    }
    
    func setClearIcon(image: UIImage) {
        setImage(image, for: .clear, state: .normal)
    }
}
