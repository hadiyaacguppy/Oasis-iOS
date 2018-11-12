//
//  URLRequest+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
public extension URLRequest {
    
    ///
    /// - Parameter urlString: URL string to initialize URL request from
    public init?(urlString: String) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(url: url)
    }
    
}
