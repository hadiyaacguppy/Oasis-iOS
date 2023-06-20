//
//  User.swift
//  Oasis
//
//  Created by Wassim on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation

public struct User : Codable {
    
    //public let token : String?
    public let isAdult : Bool?
    public let isFemale : Bool?
    public let firstName : String?
    public let lastName : String?
    public let profileImage : String?

    
    enum CodingKeys: String, CodingKey {
        //case token = "token"
        case isAdult = "IsAdult"
        case isFemale = "IsFemale"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        //token = try? values?.decodeIfPresent(String.self, forKey: .token)
        isAdult = try? values?.decodeIfPresent(Bool.self, forKey: .isAdult)
        isFemale = try? values?.decodeIfPresent(Bool.self, forKey: .isFemale)
        firstName = try? values?.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try? values?.decodeIfPresent(String.self, forKey: .lastName)
        profileImage = try? values?.decodeIfPresent(String.self, forKey: .profileImage)
    }
    
}
