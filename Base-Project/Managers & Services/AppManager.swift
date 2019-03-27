//
//  AppManager.swift
//  Base-Project
//
//  Created by Wassim on 3/27/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
class AppManager {
    
    
    
    var appName: String? {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
    
    
    var bundleId: String? {
        return Bundle.main.bundleIdentifier
    }
    
    
    var versionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    
    var buildNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    
}


