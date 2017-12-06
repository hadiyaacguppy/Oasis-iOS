//
//  String+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import Foundation
extension String {
    
    
    func asURL() -> URL? {
        return URL(string: self)
    }
    
}
