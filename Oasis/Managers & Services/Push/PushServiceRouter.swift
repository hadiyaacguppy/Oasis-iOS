//
//  PushServiceRouter.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 28/04/2022.
//  Copyright © 2022 Tedmob. All rights reserved.
//

import UIKit

//MARK: Routes
enum PushType: String{
    case general = "general"
    case none
}

//MARK: Notification-Queue
public final class PushServiceRouter {
    
    static let shared = PushServiceRouter()
    
    var notificationsQueue = Queue<PushMessageContent>()
    
    var hasNotifications : Bool{
        !notificationsQueue.isEmpty
    }
    
    func open(notification : PushMessageContent){
        notificationsQueue.enqueue(notification)
        if notification.type == .general {
            guard let messageContent = notificationsQueue.dequeue() else {
                return
            }
            presentGeneralPushController(withMsg: messageContent)
        } else {
            //MARK: Here you need to check Root if SideMenu/MainTabBar/Other
            //Closure Listener -> didReceivePushNotification?()
        }
    }
    
    private func presentGeneralPushController(withMsg msg : PushMessageContent){
        guard let topVC = UIApplication.topViewController() else {
            return
        }
        let nav = BaseNavigationController(navigationBarClass: UINavigationBar.self,
                                           toolbarClass: nil)
        nav.modalPresentationStyle = .fullScreen
        let vc = R.storyboard.pushNotification.pushNotificationContainer()!
        vc.passedMessage = msg
        nav.viewControllers = [vc]
        DispatchQueue.main.async {
            topVC.present(nav,
                          animated: true,
                          completion: nil)
        }
    }
}
