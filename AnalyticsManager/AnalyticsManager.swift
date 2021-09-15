//
//  AnalyticsManager.swift
//  AnalyticsManager
//
//  Created by Wassim on 3/27/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import FirebaseAnalytics
import Firebase

public class AnalyticsManager {
    
    public static let shared  = AnalyticsManager()
    
    public init() { }
    
    public func initFirebaseApp(){
        guard FirebaseApp.app() == nil else { return }
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
    
    private func checkIfGooglePlistFileExists() -> Bool {
        guard Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil else {
            return false
        }
        return true
    }
}
extension AnalyticsManager {
    
    func logFirebase(withName name : String , andParameter params : [String:Any]? = nil ){
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: params)
    }
    
}
