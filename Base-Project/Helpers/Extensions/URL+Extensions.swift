//
//  URL+Extensions.swift
//  Base-Project
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
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false), let queryItems = components.queryItems else { return nil }
        
        var items: [String: String] = [:]
        
        for queryItem in queryItems {
            items[queryItem.name] = queryItem.value
        }
        
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
        guard let items = URLComponents(string: stringURL)?.queryItems else { return nil }
        for item in items where item.name == key {
            return item.value
        }
        return nil
    }
    public func thumbnail(fromTime time: Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)
        
        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
