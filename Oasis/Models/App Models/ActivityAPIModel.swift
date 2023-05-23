//
//  ActivityAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 19/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct Activity : Codable {

    let date : String?
    let id : Int?
    let title : String?
    let userId : String?


    enum CodingKeys: String, CodingKey {
        case date = "date"
        case id = "id"
        case title = "title"
        case userId = "user_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }


}