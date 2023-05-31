//
//  UserAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 19/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct UserAPIModel : Codable {

    let age : Int?
    let createdAt : String?
    let firstName : String?
    let id : String?
    let lastName : String?
    let profileImage : String?


    enum CodingKeys: String, CodingKey {
        case age = "age"
        case createdAt = "created_at"
        case firstName = "first_name"
        case id = "id"
        case lastName = "last_name"
        case profileImage = "profile_image"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        profileImage = try values.decodeIfPresent(String.self, forKey: .profileImage)
    }


}
