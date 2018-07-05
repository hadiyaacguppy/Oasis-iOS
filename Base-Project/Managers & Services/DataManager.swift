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
        ///Uncomment this if you want to instantiate the saved user instance
        //user = NSKeyedUnarchiver.unarchiveObject(withFile: Utilities().getFileURL("currentUser")!) as? User

        super.init()
    }
    
    ///Uncomment this if you want to archive/save the user object
    /*
    func persistData(userToArchive : User){
        self.user = userToArchive
        NSKeyedArchiver.archiveRootObject(user!, toFile: Utilities().getFileURL("currentUser")!)
    }
     */
    
    ///Uncomment the below if you want to use a function that returns the User
    /*
    func getUser() -> User?{
        return self.user
    }
    */
    
    func removeUser(){
        //Delete the archived User
        do {
            //userDef.removeObject(forKey: Constants.UserDefaultsKeys.User)
            try FileManager.default.removeItem(atPath: Utilities.File.getFileURL("User")!)
        } catch {
            // catch potential error
            print("Couldn't Remove Archived Member")
        }
    }
    
    func signOut() {
        redirectToLoginScreen()
    }
    
    func redirectToLoginScreen(){
        _ = UIStoryboard(name: R.storyboard.main.name, bundle: nil)
        let controller = R.storyboard.main.instantiateInitialViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = controller
    }
    
    /*
     Return the access token For the current user
     
     - returns: access token String is avialable, nil if not
     
     func getAccesToken() -> String?{
     
     return defaults.object(forKey: Constants.UserDefaultsKeys.accessToken) as? String
     }
     */
}
