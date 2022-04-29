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

public final class OneSignalPushService: NSObject{
    
    static let shared = OneSignalPushService()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private var userId : String?
    
    public var playerId : String?{
        return userId
    }
    
    public var playerIdDidChange : ((String) -> ())?

    public var notificationsIsAllowed : Bool = false

    public func initializeOneSignal(withLaunchOptions launchOptions  : [UIApplication.LaunchOptionsKey: Any]? ,
                             andAppID appId : String){
        
        // Remove this method to stop OneSignal Debugging
        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        // OneSignal initialization
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(appId)

        let notifWillShowInForegroundHandler: OSNotificationWillShowInForegroundBlock = { notification, completion in
            logger.info("DID RECEIVE NOTIFICATION")
        }

        
        let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
            logger.info("DID OPEN NOTIFICATION")
            self.handleNotificationOpen(notification: result.notification)
        }

        OneSignal.setNotificationWillShowInForegroundHandler(notifWillShowInForegroundHandler)
        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)

        // Add OneSignalPushService as Observer
        OneSignal.add(self as OSPermissionObserver)
        OneSignal.add(self as OSSubscriptionObserver)
        
        self.userId = OneSignal.getDeviceState().userId
        
        promptForPushNotification()
    }
    
    
}

//MARK: - Permission And Subscription Delegates
extension OneSignalPushService: OSPermissionObserver, OSSubscriptionObserver{
    
    public func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges) {
        if stateChanges.from.status == OSNotificationPermission.notDetermined {
            if stateChanges.to.status == OSNotificationPermission.authorized {
                self.notificationsIsAllowed = true
            } else if stateChanges.to.status == OSNotificationPermission.denied {
                self.notificationsIsAllowed = false
            }
        }
        logger.info("PermissionStateChanges: \n\(String(describing: stateChanges))")
    }
    
    public func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
        if let userId = stateChanges.to.userId  {
            logger.info( "User id (player-id) is -- \(String(describing: stateChanges.to.userId))" )
            if self.userId == nil {
                self.userId = userId
                self.playerIdDidChange?(userId)
                return
            }
            if  self.userId! != userId {
                self.playerIdDidChange?(userId)
            }
            self.userId = userId
        }
    }
}

//MARK: - HandleNotificationObservers
extension OneSignalPushService{
    private func handleNotificationOpen(notification : OSNotification){
        guard let title = notification.title else { return }
        guard let body = notification.body else { return }
        
        let image = notification.additionalData?["image_url"] as? String
        let imageHeight = notification.additionalData?["image_height"] as? Double
        let imageWidth = notification.additionalData?["image_width"] as? Double
        let pushMessage = PushMessageContent(title: title,
                                             body: body,
                                             image: image,
                                             imageHeight: imageHeight,
                                             imageWidth: imageWidth)
        PushServiceRouter.shared.open(notification: pushMessage)
    }
}

//MARK: - Prompt
extension OneSignalPushService{
    
    private func promptForPushNotification(){
        // promptForPushNotifications will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission (See step 8)
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            logger.info("User accepted notifications: \(accepted)")
        })
    }
}

//MARK: - Attributes
extension OneSignalPushService{
    public func setLanguage(code : String){
        OneSignal.setLanguage(code)
    }
    
    public func setExternalId(userId : String){
        OneSignal.setExternalUserId(userId)
    }
}

//MARK: - NotificationCenter
extension OneSignalPushService{
    
    private func removeAllNotifications(){
        notificationCenter.removeAllDeliveredNotifications()
        removeAllPendingNotifications()
        resetBadgeCountNumber()
    }
    
    private func removeNotification(forId id : String){
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id])
    }
    
    private func removeAllPendingNotifications(){
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    private func resetBadgeCountNumber(){
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

