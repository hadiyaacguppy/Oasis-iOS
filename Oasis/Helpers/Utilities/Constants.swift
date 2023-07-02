//
//  Constants.swift
//  Oasis
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit

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
        static let baseURl : String = "http://3.16.20.24/"
    }
    
    struct Colors {
        static let background : UIColor = .brown
        static let defaultTint : UIColor = .green
        static let cell_background : UIColor = .yellow
        static let appColor : UIColor  = .init(hexFromString: "3030D0") // purple
        static let glowColor : UIColor = .init(red: 197, green: 93, blue: 207) //almost pink
        static let aquaMarine : UIColor = .init(hexFromString: "#00DEB5")
        static let textviewBGColor : UIColor = .init(red: 244, green: 244, blue: 244)
        static let blueToastViewColor : UIColor = .init(hexFromString: "3a68c9")
        static let lightGrey : UIColor = .init(red: 248, green: 250, blue: 251)
        static let extraLightGrey : UIColor = .init(hexFromString: "#F8FAFB")
        static let appGrey : UIColor = .init(hexFromString: "#ECEBE8")
        static let orangeYellow : UIColor = .init(hexFromString: "#ffb410")
        static let lightGreen : UIColor = .init(red: 224, green: 242, blue: 236)
        static let appViolet : UIColor = .init(hexFromString: "#3030D0")
        static let appPink : UIColor = .init(hexFromString: "#FF97D6")
        static let appGreen : UIColor = .init(hexFromString: "#00DEB5")
        static let appYellow : UIColor = .init(hexFromString: "#FFC500")
        static let lightYellow : UIColor = .init(hexFromString: "#F1E5BC")
        static let appOrange : UIColor = .init(hexFromString: "#FE4B00")
        static let maleBGColor : UIColor = .init(hexFromString: "#CCD8EB")
        static let femaleBGColor : UIColor = .init(hexFromString: "#F5ECEC")
        static let teensOrange : UIColor = .init(hexFromString: "#E94100")
        static let teensGoals : UIColor = .init(hexFromString: "#D5EDE4")
        static let teensYellow : UIColor = .init(hexFromString: "#FDC42E")






        
        struct Navigation {
            static let background : UIColor = Constants.Colors.appColor
        }

        struct TabBar {
            static let itemBackground : UIColor = .white
            static let title : UIColor = .white
        }
        
        struct TableView{
            static let preferredCellBackgroundColor : UIColor = .white
        }
    }
    
    struct StatusBarAppearance {
        static let appStyle : UIStatusBarStyle = .lightContent
        static let animationStyle : UIStatusBarAnimation = .fade
    }
    
    struct UserDefaultsKeys {
        
    }
    
    struct DictionaryKeys {
        
    }
    
    struct DefaultValues {
        static let SMSTimerInterval = 60
        static let notAvailable = "N/A".localized
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
    
    
    //MARK: - Media Manager
    struct MediaManager {
        static let actionFileTypeHeading = "Add a File"
        static let actionFileTypeDescription = "Choose a filetype to add..."
        static let camera = "Camera"
        static let phoneLibrary = "Phone Library"
        static let video = "Video"
        static let file = "File"
        
        static let alertForPhotoLibraryMessage = "App does not have access to your photos. To enable access, tap settings and turn on Photo Library Access."
        
        static let alertForCameraAccessMessage = "App does not have access to your camera. To enable access, tap settings and turn on Camera."
        
        static let alertForVideoLibraryMessage = "App does not have access to your video. To enable access, tap settings and turn on Video Library Access."
        
        
        static let settingsBtnTitle = "Settings"
        static let cancelBtnTitle = "Cancel"
        
    }
    
    struct DeepLink {
        static let minimumAppVersion = "1.0.0"
        static let appStoreId = ""
        static let androidPackageName = ""
        static let androidMinimumVersion = 1
        static let deepLinkURL = ""
        static let dynamicLinksDomainURIPrefix = ""
        static let dynamicLinksFallbackUrl = ""
    }
    
    struct Tedmob {
        static let youtube = "https://www.youtube.com/channel/UC-StGhNhuiivUU_kCHV9GcA"
        static let facebook = "https://www.facebook.com/TEDMOB"
        static let linkedin = "https://www.linkedin.com/company/tedmob"
        static let instagram = "https://www.instagram.com/tedmob.agency/"
        static let twitter = "https://twitter.com/ted_mob"
        static let website = "www.tedmob.com"
    }
    
}
