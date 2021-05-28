//
//  APIErrorModel.swift
//  Base-Project
//
//  Created by Mojtaba Al Moussawi on 4/12/21.
//  Copyright © 2021 Tedmob. All rights reserved.
//

import Foundation

struct APIErrorModel : Codable {
    let code : Int?
    let debugger : String?
    let message : String?
}
