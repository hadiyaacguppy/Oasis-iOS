//
//  AppDelegate+OneSignal.swift
//  Base-Project
//
//  Created by Wassim on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func initOneSignal(withLaunchOption launchOptions: [UIApplication.LaunchOptionsKey: Any]?, andOneSignalId oneSignalID: String) {
        OneSignalPushService.shared.initializeOneSignal(withLaunchOptions: launchOptions, andAppID: oneSignalAppId)
        OneSignalPushService.shared.playerIdDidChange = { token in
            _ = APIClient.shared.setOneSignalToken(withToken: token)
                .subscribe()
            
        }
    }
    
}
