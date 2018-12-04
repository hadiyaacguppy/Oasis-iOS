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
    var playerIdDidChange : ((String) -> ())?

    var notificationsIsAllowed : Bool = false
    var receivedNotifications : Array<OSNotification> = Array<OSNotification>()
    
    
    
    func initializeOneSignal(withLaunchOptions launchOptions  : [UIApplicationLaunchOptionsKey: Any]? ,andAppID appId : String){
        
        
        
        // Add OneSignalPushService as Observer
        OneSignal.add(self as OSPermissionObserver)
        OneSignal.add(self as OSSubscriptionObserver)
        self.userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId
        
        
        let  notificationReceivedBlock : OSHandleNotificationReceivedBlock = { notification in
            guard notification != nil else {
                return
            }
            self.receivedNotifications.append(notification!)
            
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
            
            print( "User id (player-id) is --" + stateChanges.to.userId)
            if self.userId != nil && self.userId! != userId {
                self.playerIdDidChange?(userId)
            }
            self.userId = userId
            

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
        
        
        if let payload = self.payLoadMessage {
            PushParser.shared.handlerDidReceivePush(withPayload: payload)
            self.payLoadMessage = nil
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
        self.receivedNotifications.removeNotification(Withid: id)
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
extension Array where Element == OSNotification {
    
    mutating func removeNotification(Withid id : String){
        for  (index , element) in self.enumerated() {
            if element.payload.notificationID == id {
                self.remove(at: index)
                break
            }
        }
    }
    
}
