//
//  RegistrationManager.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 07/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

class RegistrationDataManager {
    
    static let current = RegistrationDataManager()
    private init() {}
    
    var userEmail : String?
    var userAge : String?
    var userFirstName : String?
    var userLastName : String?
    var userMobileNumber : String?
    var userPassword : String?
    var userFile : String?
    
}

