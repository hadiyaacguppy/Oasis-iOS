//
//  NotificationPayload.swift
//  Base-Project
//
//  Created by Wassim on 11/13/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import  OneSignal
struct NotificationPayload  {
    
    /* Notification Payload */
    public private(set) var payload : OSNotificationPayload?
    
    /* Set to true when the user was able to see the notification and reacted to it
     Set to false when app is in focus and in-app alerts are disabled, or the remote notification is silent. */
    public private(set) var wasShown : Bool?
    
    
    
    /* Set to true if the app was in focus when the notification  */
    public private(set) var wasAppInFocus : Bool?
    
    /* Set to true when the received notification is silent
     Silent means there is no alert, sound, or badge payload in the aps dictionary
     requires remote-notification within UIBackgroundModes array of the Info.plist */
    public private(set) var isSilentNotification : Bool?
    
}
