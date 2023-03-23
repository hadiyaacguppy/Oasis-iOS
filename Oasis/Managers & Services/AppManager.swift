//
//  AppManager.swift
//  Oasis
//
//  Created by Wassim on 3/27/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import UIKit

class AppManager {
    
    static let current =  AppManager()
    private init() {}
    var appName: String {
        return (Bundle.main.infoDictionary?["CFBundleName"] as? String) ?? ""
    }
    
    
    var bundleId: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    
    var versionNumber: String {
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? ""
    }
    
    
    var buildNumber: String {
        return ( Bundle.main.infoDictionary?["CFBundleVersion"] as? String) ?? "" 
    }
    func openAppSettings(){
        if Utilities.canOpen(url: URL(string:UIApplication.openSettingsURLString)){
            Utilities.openURL(withString: UIApplication.openSettingsURLString)
        }
    }
    
    
}


