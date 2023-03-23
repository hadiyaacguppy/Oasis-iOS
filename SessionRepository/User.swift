//
//  User.swift
//  Oasis
//
//  Created by Wassim on 6/28/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation

public struct User : Codable {
    
    public let token : String?
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        token = try? values?.decodeIfPresent(String.self, forKey: .token)
    }
    
}
