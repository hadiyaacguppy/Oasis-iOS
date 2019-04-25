//
//  AnalyticsManager.swift
//  AnalyticsManager
//
//  Created by Wassim on 3/27/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import Firebase
public class AnalyticsManager {
    
    public static let shared  = AnalyticsManager()
    init() {
        guard checkIfGooglePlistFileExists() else {
            print("GoogleService-Info.plist does not exists. not initiating analytics manager")
            return
        }
        FirebaseApp.configure()
    }
    
    
    public func logEvent(withName name : String , andParameters params : [String : Any]? = nil ) {
        var newParams = params
        if newParams == nil {
            newParams = ["platform" : "ios"]
        }else {
            newParams!["platform"] =  "ios"
        }
        self.logFirebase(withName: name, andParameter: newParams)
        
    }
    func checkIfGooglePlistFileExists() -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        guard let pathComponent = url.appendingPathComponent("GoogleService-Info.plist")  else {
            return false
        }
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: filePath) {
            return true
        } else {
            return false
        }
    }
}
extension AnalyticsManager {
    func logFirebase(withName name : String , andParameter params : [String:Any]? = nil ){
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
    }
}
