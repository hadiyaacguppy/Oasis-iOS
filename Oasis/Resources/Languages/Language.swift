//
//  LanguageAPIModel.swift
//  Oasis
//
//  Created by Mojtaba Al Moussawi on 26/04/2022.
//  Copyright © 2022 Tedmob. All rights reserved.
//

import Foundation

struct Language : Codable {
    let code : String?
    let name : String?
    let nativeField : String?
    let rtl : Int?
}
