//
//  Decodable+Extensions.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 4/12/21.
//  Copyright © 2021 Tedmob. All rights reserved.
//

import Foundation

extension Decodable {
  init(from: Any) throws {
    let data = try JSONSerialization.data(withJSONObject: from, options: .prettyPrinted)
    let decoder = JSONDecoder()
    self = try decoder.decode(Self.self, from: data)
  }
}
