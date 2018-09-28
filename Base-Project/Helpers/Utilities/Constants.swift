//
//  Constants.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    
    
    
    
    struct Network {
        
        static let baseURl : String = "https://google.com"
        static let SessionTokenExpiredCode = -777
        
    }
    
    
    
    struct Colors {
        static let appColor : UIColor  = .white
    }
    
    struct UserDefaultsKeys {
        
    }
    
    struct DictionaryKeys {
        
    }
    
    struct DefaultValues {
        
    }
    
    struct ControllersIdentifiers {
        
    }
    
    struct SegueIdentifiers {
        
    }
    
    struct  NSTimerIntervals {
        
    }
    struct URLSchemas{
        
        enum Browsers : String{
            case securedChrome = "googlechromes://"
            case notSecuredChrome = "googlechrome://"
            case securedFireFox = "firefox://open-url?url=https://"
            case notSecuredFireFox = "firefox://open-url?url=http://"
            case securedOpera = "opera://open-url?url=https://"
            case notSecuredOpera = "opera://open-url?url=http://"
        }
        
        enum SocialMediaApps : String{
            case whatsapp = "whatsapp://"
        }
    }

}
