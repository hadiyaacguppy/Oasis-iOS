//
//  OneSignalPushService.swift
//  Base-Project
//
//  Created by Wassim on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import UIKit
import OneSignal
import RxSwift



struct NotificationPayloadReceivedObject {
    
    /* Unique Message Identifier */
    public private(set) var notificationId : String?
    
    /* True when the key content-available is set to 1 in the aps payload.
     content-available is used to wake your app when the payload is received.
     See Apple's documenation for more details.
     https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1623013-application
     */
    public private(set) var contentAvailable : String?
    
    /* True when the key mutable-content is set to 1 in the aps payload.
     mutable-content is used to wake your Notification Service Extension to modify a notification.
     See Apple's documenation for more details.
     https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension
     */
    public private(set) var mutableContent : String?
    
    /* The badge assigned to the application icon */
    public private(set) var badge : UInt?
    public private(set) var badgeIncrement : Int?
    
    /* The sound parameter passed to the notification
     By default set to UILocalNotificationDefaultSoundName */
    public private(set) var sound : String?
    
    /* Main push content */
    public private(set) var title : String?
    public private(set) var subtitle : String?
    public private(set) var body : String?
    
    /* Web address to launch within the app via a UIWebView */
    public private(set) var launchURL : String?
    
    /* Additional key value properties set within the payload */
    public private(set) var additionalData : [AnyHashable : Any]?
    
    /* iOS 10+ : Attachments sent as part of the rich notification */
    public private(set) var attachments : String?
    
    /* Action buttons passed */
    public private(set) var actionButtons : String?
    
    /* Holds the original payload received
     Keep the raw value for users that would like to root the push */
    public private(set) var rawPayload : String?
    
}


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


final class OneSignalPushService: NSObject{
    
    
    static let shared = OneSignalPushService()
    
    fileprivate var payLoadMessage : NotificationPayload?
    
    private lazy var timerToSendAddtionalData : Timer = Timer.scheduledTimer(timeInterval: 0.5,
                                                                             target: self,
                                                                             selector: #selector(self.trytoSendAddtionalData),
                                                                             userInfo: nil, repeats: true
    )
    
    private let center = UNUserNotificationCenter.current()
    
    private var userId : String?
    
    var playerId : String?{
        return userId
    }
    
    var notificationsIsAllowed : Bool = false
    
    
    
    func initializeOneSignal(withLaunchOptions launchOptions  : [UIApplicationLaunchOptionsKey: Any]? ,andAppID appId : String){
        
        
        
        // Add OneSignalPushService as Observer
        OneSignal.add(self as OSPermissionObserver)
        OneSignal.add(self as OSSubscriptionObserver)
        self.userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId
        
        
        let  notificationReceivedBlock : OSHandleNotificationReceivedBlock = { notification in
            //TODO:
            
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            self.setupNotificationAction(withResult: result)
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false,kOSSettingsKeyInAppLaunchURL: true]
        
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appId,
                                        handleNotificationReceived: notificationReceivedBlock, handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = .notification
        promptForPushNotification()
    }
    
}

//MARK: Permission And Subscription Delegates
extension OneSignalPushService: OSPermissionObserver,OSSubscriptionObserver{
    
    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges!) {
        // Example of detecting answering the permission prompt
        if stateChanges.from.status == OSNotificationPermission.notDetermined {
            if stateChanges.to.status == OSNotificationPermission.authorized {
                self.notificationsIsAllowed = true
            } else if stateChanges.to.status == OSNotificationPermission.denied {
                self.notificationsIsAllowed = false
            }
        }
        // prints out all properties
        print("PermissionStateChanges: \n\(stateChanges)")
    }
    
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges!) {
        if let userId = stateChanges.to.userId  {
            self.userId = userId
            print( "User id (player-id) is --" + stateChanges.to.userId)
        }
        
    }
    
    
    
}


extension OneSignalPushService{
    
    func promptForPushNotification(){
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
    }
    
    func setupNotificationAction(withResult result : OSNotificationOpenedResult?){
        
        let payload = NotificationPayload(payload: result?.notification.payload, wasShown: result?.notification.wasShown  , wasAppInFocus: result?.notification.wasAppInFocus, isSilentNotification: result?.notification.isSilentNotification )
        
        
        self.payLoadMessage = payload
        
        self.timerToSendAddtionalData = Timer.scheduledTimer(timeInterval: 5,
                                                             target: self,
                                                             selector: #selector(self.trytoSendAddtionalData),
                                                             userInfo: nil, repeats: true
        )
        
        self.timerToSendAddtionalData.fire()
        
    }
    
    @objc
    func trytoSendAddtionalData(){
        guard self.payLoadMessage != nil else {
            self.timerToSendAddtionalData.invalidate()
            return
        }
        
        
        
        guard UIApplication.topViewController() != nil else {
            return
        }
        
        
        if let additionalData = self.payLoadMessage?.payload?.additionalData{
            PushParser.shared.handlerDidReceivePush(withUserInfo: additionalData)
        }
        
        
    }
    
}

extension OneSignalPushService{
    
    func removeAllNotifications(){
        center.removeAllDeliveredNotifications()
        removeAllPendingNotifications()
        resetBadgeCountNumber()
    }
    
    func removeNotification(forId id : String){
        center.removeDeliveredNotifications(withIdentifiers: [id])
    }
    
    fileprivate
    func removeAllPendingNotifications(){
        center.removeAllPendingNotificationRequests()
    }
    
    fileprivate
    func resetBadgeCountNumber(){
        UIApplication.shared.applicationIconBadgeNumber = 0 // to clear the icon notification badge
    }
}

//TODO : Deep Link
