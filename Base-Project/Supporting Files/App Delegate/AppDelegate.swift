//
//  AppDelegate.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/4/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    var oneSignalAppId : String = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("Base Project Version 2.0")
        OneSignalPushService.shared.initializeOneSignal(withLaunchOptions: launchOptions, andAppID: oneSignalAppId)
        OneSignalPushService.shared.playerIdDidChange = { token in
            _ = APIClient.shared.setOneSignalToken(withToken: token)
                .subscribe()
            
        }
        
        UIView().createActivityIndicator()
        
        return true
    }





}

