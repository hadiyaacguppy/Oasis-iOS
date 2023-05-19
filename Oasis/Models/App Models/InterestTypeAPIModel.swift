//
//  Interest.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct InterestTypeAPIModel : Codable {

    let id : Int?
    let image : String?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }


}
