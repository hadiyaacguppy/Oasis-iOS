//
//  PushService.swift
//  Base-Project
//
//  Created by Wassim on 8/8/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

class PushParser {
    
    static let shared = PushParser()
    
    func handleDidReceiveNotification(withPayload payload : NotificationPayload){
        
    }
    
    
    func handleDidOpenNotification(withPayload payload : NotificationPayload){
        guard let title = payload.payload?.title else { return }
        guard let body = payload.payload?.body else { return }
        
        let image = payload.payload?.additionalData?["image_url"] as? String
        let imageHeight = payload.payload?.additionalData?["image_height"] as? Double
        let imageWidth = payload.payload?.additionalData?["image_width"] as? Double
        let pushMessage = PushMessageContent(title: title, body: body, image: image, imageHeight: imageHeight, imageWidth: imageWidth)
        /* do the routing */
        
    }
    
}
