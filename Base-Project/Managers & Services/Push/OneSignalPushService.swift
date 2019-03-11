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
    
    
    var shouldShowNotificationWhileAppIsOpen : Bool = true {
        didSet {
            updateInFocusDisplayType()
        }
    }
    func initializeOneSignal(withLaunchOptions launchOptions  : [UIApplication.LaunchOptionsKey: Any]? ,andAppID appId : String){
        
        
        
        // Add OneSignalPushService as Observer
        OneSignal.add(self as OSPermissionObserver)
        OneSignal.add(self as OSSubscriptionObserver)
        
        self.userId = OneSignal.getPermissionSubscriptionState().subscriptionStatus.userId
        
        
        let  notificationReceivedBlock : OSHandleNotificationReceivedBlock = { notification in
            guard notification != nil else {
                return
            }
            print("DID RECEIVE NOTIFICATION")
            
            PushParser.shared.handleDidReceiveNotification(withPayload: NotificationPayload(payload: notification!.payload, wasShown: notification!.wasShown, wasAppInFocus: notification!.wasAppInFocus, isSilentNotification: notification!.isSilentNotification))
            
            //            self.receivedNotifications.append(notification!)
            
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
    
    func updateInFocusDisplayType(){
        if self.shouldShowNotificationWhileAppIsOpen {
            OneSignal.inFocusDisplayType = .notification
        }else {
            OneSignal.inFocusDisplayType = .none
        }
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
            PushParser.shared.handleDidOpenNotification(withPayload: payload)
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
