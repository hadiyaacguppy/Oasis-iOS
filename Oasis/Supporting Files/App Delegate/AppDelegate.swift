//
//  AppDelegate.swift
//  Oasis
//
//  Created by Wassim Seifeddine on 12/4/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//


import RxSwift
import Logging
import AnalyticsManager
import TDPopupKit
import Mixpanel

var logger = Logger(label: "Oasis-Logger")

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var oneSignalAppId : String = ""
    var sessionExpiryRelaySubscription: Disposable?
    
    //
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    -> Bool {
        logger.info("Base Project Version 4.0")
        configurePopupKitAppearance()
        
        if !self.oneSignalAppId.isEmpty {
            initOneSignal(withLaunchOption: launchOptions, andOneSignalId: oneSignalAppId)
        }else {
            logger.warning("Will not init OneSignal. App ID is empty")
        }
        
        subscribeToSessionExpiryRelay()
        
        Mixpanel.initialize(token: "7c860fdffdb2f33c5a4364033d0d11cf", trackAutomaticEvents: true)
        
        return true
    }
    
    override init() {
        super.init()
        AnalyticsManager.shared.initFirebaseApp()
    }
}

