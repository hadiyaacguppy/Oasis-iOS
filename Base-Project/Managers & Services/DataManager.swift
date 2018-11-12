//
//  DataManager.swift
//  Base-Project
//
//  Created by Hadi on 7/5/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper



class DataManager: NSObject {
    
    ///Uncomment This if you want to create a saved instance from the user object
    //var user: User? = nil
    
    static let instance = DataManager()
    
    override init() {
        
        super.init()
    }
    
    
}
