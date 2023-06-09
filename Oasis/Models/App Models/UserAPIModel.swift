//
//  UserAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 19/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct UserAPIModel : Codable {

    let isAdult : Bool?
    let isFemale : Bool?
    let firstName : String?
    let lastName : String?
    let profileImage : String?


    enum CodingKeys: String, CodingKey {
        case isAdult = "IsAdult"
        case isFemale = "IsFemale"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isAdult = try values.decodeIfPresent(Bool.self, forKey: .isAdult)
        isFemale = try values.decodeIfPresent(Bool.self, forKey: .isFemale)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }


}
