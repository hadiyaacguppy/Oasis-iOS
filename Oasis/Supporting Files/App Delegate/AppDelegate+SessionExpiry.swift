//
//  AppDelegate+SessionExpiry.swift
//  Oasis
//
//  Created by Wassim on 7/1/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation

extension AppDelegate {
    func subscribeToSessionExpiryRelay() {
        sessionExpiryRelaySubscription = Relays.shared.sessionIsExpired.subscribe(onNext: { _ in
            logger.warning("SESSION EXPIRED")
        })
    }
}
