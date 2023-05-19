//
//  Payment.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 17/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct PaymentAPIModel : Codable {

    let amount : Int?
    let createdAt : String?
    let currency : String?
    let date : String?
    let id : Int?
    let paymentType : String?
    let title : String?
    let userId : String?


    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case createdAt = "created_at"
        case currency = "currency"
        case date = "date"
        case id = "id"
        case paymentType = "payment_type"
        case title = "title"
        case userId = "user_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        userId = try values.decodeIfPresent(String.self, forKey: .userId)
    }


}
