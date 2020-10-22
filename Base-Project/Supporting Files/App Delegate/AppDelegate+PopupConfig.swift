//
//  AppDelegate+PopupConfig.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 10/22/20.
//  Copyright © 2020 Tedmob. All rights reserved.
//

import TDPopupKit

extension AppDelegate{
    
    /// Will be called by didFinishLaunchingWithOptions function to configure TDPopupKit Appearance
     func configurePopupKitAppearance(){
        
        /** You can customize the text color and popups background color */
        PopupService.preferences.config.loadingPopupStyle = .init(textColor: <#T##UIColor#>, popupBackgroundColor: <#T##UIColor#>)
        PopupService.preferences.config.successPopupStyle = .init(textColor: <#T##UIColor#>, popupBackgroundColor: <#T##UIColor#>)
        PopupService.preferences.config.errorPopupStyle = .init(textColor: <#T##UIColor#>, popupBackgroundColor: <#T##UIColor#>)
        
        /** You can customize as well the default fonts used by PopupKit */
        
        /*
        PopupService.preferences.config.titleFont //
        */
 
    }
}
