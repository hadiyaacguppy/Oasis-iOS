//
//  InputValidationExpressio.swift
//  Base-Project
//
//  Created by Wassim on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

enum InputValidationExpression : String {
    case emailValid = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case passwordStrong = "o"
    case passwordMedium = "d"
    case passwordWeak = "q"
    case other = "now"
    case mobileValid = "^((\\+)|(00))[0-9]{6,14}$"
    case urlValid = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
    case onlyNumber = "^[0-9]+$"
    case onlyDecimal = "\\d+(\\.\\d{1,2})?"
    case heightValid = "\\d{1,2}+(\\.\\d{1,2})?"
    case weightValid = "\\d{1,3}+(\\.\\d{1,2})?"
}
