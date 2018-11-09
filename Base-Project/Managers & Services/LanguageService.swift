//
//  LanguageService.swift
//  Base-Project
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation



enum Languages:String {
    case arabic = "ar"
    case english = "en"
}
class LanguageService {
    
    var rtlLanguages : [Languages] = [.arabic]
    
    fileprivate var dl = Locale.current.languageCode
    
    var deviceLang : Languages{
        guard let dl = dl else {
            return .english
        }
        switch true {
        case dl.contains(Languages.arabic.rawValue):
            return .arabic
        case dl.contains(Languages.english.rawValue):
            return .english
        default :
            return .english
        }
        
    }
    
    var isRTL : Bool{
        return rtlLanguages.contains(deviceLang)
    }
}
