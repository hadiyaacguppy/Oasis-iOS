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

import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    var oneSignalAppId : String = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("Base Project Version 0.1.4")
        OneSignalPushService.shared.initializeOneSignal(withLaunchOptions: launchOptions, andAppID: oneSignalAppId)
        return true
    }





}

