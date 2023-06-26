//
//  Task.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct TasksAPIModel : Codable {

    let amount : Int?
    let childId : String?
    let createdAt : String?
    let currency : String?
    let id : Int?
    let taskType : String?
    let title : String?


    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case childId = "child_id"
        case createdAt = "created_at"
        case currency = "currency"
        case id = "id"
        case taskType = "task_type"
        case title = "title"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        childId = try values.decodeIfPresent(String.self, forKey: .childId)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        taskType = try values.decodeIfPresent(String.self, forKey: .taskType)
        title = try values.decodeIfPresent(String.self, forKey: .title)
    }


}
