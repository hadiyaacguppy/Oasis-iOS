//
//  UserRootAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 30/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct UserRootAPIModel : Codable {

    let token : String?
    let user : UserAPIModel?


    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        user = try values.decodeIfPresent(UserAPIModel.self, forKey: .user)
    }
}
