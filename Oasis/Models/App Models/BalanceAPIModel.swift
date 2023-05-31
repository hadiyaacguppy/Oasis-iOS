//
//  BalanceAPIModel.swift
//  Oasis
//
//  Created by Hadi Yaacoub on 30/05/2023.
//  Copyright © 2023 Tedmob. All rights reserved.
//

import Foundation

struct BalanceAPIModel : Codable {

    let balance : Int?


    enum CodingKeys: String, CodingKey {
        case balance = "balance"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        balance = try values.decodeIfPresent(Int.self, forKey: .balance)
    }


}
