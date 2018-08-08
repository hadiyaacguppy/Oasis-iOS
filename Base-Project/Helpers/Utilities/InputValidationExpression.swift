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
}
