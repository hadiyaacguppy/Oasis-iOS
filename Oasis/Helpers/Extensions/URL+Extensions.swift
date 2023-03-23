//
//  URL+Extensions.swift
//  Oasis
//
//  Created by Wassim on 9/28/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

extension URL{
    
    var isHTTPSchema : Bool{
        return scheme?.hasPrefix("http") == true
    }
    
    var isHTTPSSchema : Bool{
        return scheme?.hasPrefix("https") == true
    }
    
    public var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems else { return nil }
        
        var items: [String: String] = [:]
        queryItems.forEach { items[$0.name] = $0.value }
        return items
    }

    public func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map({ URLQueryItem(name: $0, value: $1) })
        urlComponents.queryItems = items
        return urlComponents.url!
    }
    
    
    
    public func queryValue(for key: String) -> String? {
        let stringURL = absoluteString
        return stringURL.queryValue(for: key)
    }
   
}
