//
//  Child.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct Child : Codable {

    let age : String?
    let avatarId : String?
    let balance : Int?
    let firstName : String?
    let goals : [Goal]?
    let id : String?
    let lastName : String?
    let parentId : String?
    let profile : String?
    let spent : Int?
    let tasks : [Tasks]?


    enum CodingKeys: String, CodingKey {
        case age = "age"
        case avatarId = "avatar_id"
        case balance = "balance"
        case firstName = "first_name"
        case goals = "goals"
        case id = "id"
        case lastName = "last_name"
        case parentId = "parent_id"
        case profile = "profile"
        case spent = "spent"
        case tasks = "tasks"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        avatarId = try values.decodeIfPresent(String.self, forKey: .avatarId)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        goals = try values.decodeIfPresent([Goal].self, forKey: .goals)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        parentId = try values.decodeIfPresent(String.self, forKey: .parentId)
        profile = try values.decodeIfPresent(String.self, forKey: .profile)
        spent = try values.decodeIfPresent(Int.self, forKey: .spent)
        tasks = try values.decodeIfPresent([Tasks].self, forKey: .tasks)
    }


}
