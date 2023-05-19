//
//  Goal.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct GoalAPIModel : Codable {

    let amount : Int?
    let createdAt : String?
    let currency : String?
    let endDate : String?
    let id : Int?
    let image : String?
    let saved : Int?
    let title : String?
    let userId : String?


    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case createdAt = "created_at"
        case currency = "currency"
        case endDate = "end_date"
        case id = "id"
        case image = "image"
        case saved = "saved"
        case title = "title"
        case userId = "user_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        saved = try values.decodeIfPresent(Int.self, forKey: .saved)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }


}

