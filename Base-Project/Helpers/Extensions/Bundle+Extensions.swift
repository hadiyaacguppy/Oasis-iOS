//
//  Bundle+Extensions.swift
//  Base-Project
//
//  Created by Hadi Yaacoub on 9/27/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation


extension Bundle {
    
    var appName: String {
        return infoDictionary?["CFBundleName"] as! String
    }
    
    var bundleId: String {
        return bundleIdentifier!
    }
    
    var versionNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as! String
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleVersion"] as! String
    }
    
}
