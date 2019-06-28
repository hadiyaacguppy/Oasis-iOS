//
//  SessionManager.swift
//  SessionManager
//
//  Created by Wassim on 6/11/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

public class SessionManager {
    
    public init(){
        
    }
    public var token : String? {
        get {
            return self.currentUser.token
        }set {
            self.currentUser.token = newValue
            
        }
    }
    public var currentUser: User {
        get {
            //NSKEyed Archiver get
            return User()
        }
        set {
            // Set them
            
        }
    }
    
    
    public var isFirstTime : Bool {
        if !UserDefaults.standard.bool(forKey: SessionManagerConstants.UserDefaultKeys.firsTime) {
            UserDefaults.standard.set(true , forKey: SessionManagerConstants.UserDefaultKeys.firsTime)
            return true
        }
        return false
    }
    public var userIsLoggedIn : Bool! {
        return  self.currentUser != nil
    }
    
    public var isInExploreMode : Bool = false
    
    public func sessionIsValid(withErrorCode code : Int) -> Bool {
         return code != SessionManagerConstants.sessionExpiredCode
            
    }
    
    
}
