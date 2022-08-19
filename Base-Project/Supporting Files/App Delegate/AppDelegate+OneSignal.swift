//
//  AppDelegate+OneSignal.swift
//  Base-Project
//
//  Created by Wassim on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import UIKit
import SessionRepository

extension AppDelegate {
    
    func initOneSignal(withLaunchOption launchOptions: [UIApplication.LaunchOptionsKey: Any]?,
                       andOneSignalId oneSignalID: String) {
        OneSignalPushService.shared.initializeOneSignal(withLaunchOptions: launchOptions,
                                                        andAppID: oneSignalID)
        OneSignalPushService.shared.playerIdDidChange = { token in
            guard SessionRepository.shared.token != nil else {
                return
            }
            _ = APIClient.shared.setOneSignalToken(withToken: token)
                .subscribe()
        }
    }
}
