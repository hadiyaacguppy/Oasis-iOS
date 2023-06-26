//
//  UserRootAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 30/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation
import SessionRepository

struct UserRootAPIModel : Codable {

    let token : String?
    let user : User?


    enum CodingKeys: String, CodingKey {
        case token = "token"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.token, forKey: .token)
        try container.encodeIfPresent(self.user, forKey: .user)
    }
}
