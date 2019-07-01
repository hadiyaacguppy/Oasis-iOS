//
//  SessionRepository.swift
//  SessionRepository
//
//  Created by Wassim on 6/11/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation

public class SessionRepository {
    
    public init(){}
    
    public var token : String? {
        get {
            return self.currentUser?.token
        }set {
            if currentUser == nil {
                let newUser = User()
                newUser.token = newValue
                self.currentUser = newUser
                
            }else{
                self.currentUser?.token = newValue
            }
            
            
        }
    }
    
    public var currentUser: User? {
        get {
            return getArchivedUser()
        }
        set {
            guard let newValue = newValue else {
                print("Removing User Object ")
                deleteArhivedUser()
                return
            }
            print("Saving User Object")
            persistUser(user: newValue)
            
        }
    }
    
    public var isFirstTime : Bool {
        if !UserDefaults.standard.bool(forKey: SessionRepositoryConstants.UserDefaultKeys.firstTime) {
            UserDefaults.standard.set(true , forKey: SessionRepositoryConstants.UserDefaultKeys.firstTime)
            return true
        }
        return false
    }
    
    public var userIsLoggedIn : Bool! {
        return  self.currentUser != nil && self.currentUser?.token != nil
    }
    
    public var isInExploreMode : Bool = false
    
    public func sessionIsValid(withErrorCode code : Int) -> Bool {
        return code != SessionRepositoryConstants.sessionExpiredCode
        
    }
    
    public func prepareLogout( _ handler :(() -> ())? = nil ) {
        self.currentUser = nil
        self.token = nil
    }
    
}
private extension SessionRepository {
    
    func persistUser(user : User){
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(data, forKey: SessionRepositoryConstants.UserDefaultKeys.userKey)
    }
    
    func getArchivedUser() -> User?{
        guard let data = UserDefaults.standard.value(forKey: SessionRepositoryConstants.UserDefaultKeys.userKey) as? Data else {
            return nil
        }
        
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: data) else {
            return nil
        }
        guard let user = encodedData as? User else {
            return nil
        }
        return user
    }
    
    func deleteArhivedUser() {
        UserDefaults.standard.removeObject(forKey: SessionRepositoryConstants.UserDefaultKeys.userKey)
    }
}
