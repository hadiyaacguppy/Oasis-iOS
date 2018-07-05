//
//  PushService.swift
//  Base-Project
//
//  Created by Wassim on 12/7/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
import RxSwift
import Firebase
import FirebaseMessaging
import UserNotifications
class PushService {
    
    var fcmToken : Variable<String?> = Variable(nil)
    static let shared = PushService()
    
    func handlerDidReceivePush(withUserInfo : [AnyHashable : Any]){
    }
    
    func handleDidFailToRegister(withError error : Error){
        
    }
    func didReceive(APNSToken apns : Data){
        
    }
    
    func didReceive(FCMToken fcmtoken : String){
        self.fcmToken.value = fcmtoken
    }
    func didReceive(remoteMessage msg  : MessagingRemoteMessage ){
        
    }
    
    func willPresent(notification : UNNotification , fromCenter : UNUserNotificationCenter){
        
    }
    func didReceive(notificationResponse : UNNotificationResponse , fromCenter : UNUserNotificationCenter){
        
    }
}
