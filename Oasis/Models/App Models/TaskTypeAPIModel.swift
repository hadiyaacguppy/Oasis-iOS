//
//  TaskType.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct TasksRootAPIModel : Codable {

    let taskTypes : [TaskTypeAPIModel]?


    enum CodingKeys: String, CodingKey {
        case taskTypes = "task_types"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taskTypes = try values.decodeIfPresent([TaskTypeAPIModel].self, forKey: .taskTypes)
    }


}

struct TaskTypeAPIModel : Codable {

    let id : Int?
    let name : String?


    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }


}
