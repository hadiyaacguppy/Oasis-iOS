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
    
    public static let shared = SessionRepository()
    
    public var token : String? {
        get {
            guard let accessToken = UserDefaults.standard.string(forKey: SessionRepositoryConstants.UserDefaultKeys.accessToken) else {
                return nil
            }
            return accessToken
        }set {
            print("🔐 \(#file) Sets new Access Token of \(String(describing: newValue)) in \(#function) at line \(#line) ")
            UserDefaults.standard.set(newValue, forKey: SessionRepositoryConstants.UserDefaultKeys.accessToken)
            UserDefaults.standard.synchronize()
        }
    }
    public var currentUser: User? {
        get {
            return getArchivedUser()
        }
        set {
            guard let newValue = newValue else {
                print("Removing User Object ")
                deleteArchivedUser()
                return
            }
            print("🙍‍♂️Saving User Object")
            persistUser(user: newValue)
//            if newValue.token != nil {
//                self.token = newValue.token
//            }
        }
    }
    
    public var isFirstTime : Bool {
        if !UserDefaults.standard.bool(forKey: SessionRepositoryConstants.UserDefaultKeys.firstTime) {
            UserDefaults.standard.set(true , forKey: SessionRepositoryConstants.UserDefaultKeys.firstTime)
            return true
        }
        return false
    }
    
    public var userIsLoggedIn : Bool {
        return self.token != nil
        
    }
    
    public func sessionIsValid(withErrorCode code : Int) -> Bool {
        return code != SessionRepositoryConstants.sessionExpiredCode
    }
    
    public func prepareLogout( _ handler :(() -> ())? = nil ) {
        self.currentUser = nil
        self.token = nil
        handler?()
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
    
    func deleteArchivedUser() {
        UserDefaults.standard.removeObject(forKey: SessionRepositoryConstants.UserDefaultKeys.userKey)
    }
}
