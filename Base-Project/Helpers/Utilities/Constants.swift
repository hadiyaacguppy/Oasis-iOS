//
//  Constants.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

/// All the date formats that should be used in the app
enum DateFormats : String {
    case words = "EEEE, MMM d, yyyy" //  Friday, Nov 9, 2018
    case digits = "MM-dd-yyyy HH:mm" //11-09-2018
    case monthAnYear = "MMMM yyyy" //November 2018
    case monthDayYear = "MMM d, yyyy"//Nov 9, 2018
    case shortDigits = "dd.MM.yy"//09.11.18
    case everything = "E, d MMM yyyy HH:mm:ss"
}

struct Constants {
    

    struct Network {
        static let baseURl : String = "https://google.com/"
    }
    
    struct Colors {
        static let appColor : UIColor  = .red
    }
    
    
    
    struct StatusBarAppearance {
        static let appStyle : UIStatusBarStyle = .lightContent
        static let updateAnimationStyle : UIStatusBarAnimation = .fade
    }
    
    struct UserDefaultsKeys {
        
    }
    
    struct DictionaryKeys {
        
    }
    
    struct DefaultValues {
        static let SMSTimerInterval = 60
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
        
        enum MailApps : String{
            case gmail = "googlegmail:///"
            case outlook = "ms-outlook://"
            case spark = "readdle-spark://"
            case inboxGmail = "inbox-gmail://"
        }
    }
    
 
    
    struct ProgressHud {
        struct ProgressStyle {
            static let dark = SVProgressHUDStyle.dark
            static let light = SVProgressHUDStyle.light
        }
        
        struct ProgressAnimationType {
            static let flat = SVProgressHUDAnimationType.flat
            static let native = SVProgressHUDAnimationType.native
            
        }
        static let style = ProgressStyle.dark
        static let animationType = ProgressAnimationType.native
    }
    
    
    struct PlaceHolderView {
        struct Fonts {
            
            static let  boldSubheadline  = MainFont.bold.with(size: 15)
            
        }
        struct Texts {
            static let loading = "LOADING".localized
            static let wait = "PLEASE WAIT".localized
            static let noConnection = "No network connection".localized
            static let retry = "TAP TO RETRY".localized
            static let offline = "You're offline".localized
        }
        
        struct Appearance {
            static let buttonColor : UIColor = .blue
            static let buttonCornerRaduis : CGFloat = 5
            static let buttonTextColor : UIColor = .white
            static let textColor : UIColor = .gray
            static let viewColor : UIColor = .white
            
        }
        
    }
    
    struct Error {
        static let unknown = "Unknown Error".localized
        static let badRequest = "Bad Request".localized
        static let someThingWentWrong = "SomeThing went wrong!".localized
        static let notFound = "Not Found".localized
        static let noInternet = "No internet connection".localized
    }
    
    

}
