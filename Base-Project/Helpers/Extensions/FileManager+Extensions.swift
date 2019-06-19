//
//  FileManager+Extensions.swift
//  Base-Project
//
//  Created by Wassim on 11/9/18.
//  Copyright © 2018 Tedmob. All rights reserved.
//

import Foundation
public extension FileManager {
    
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - options: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    func jsonFromFile( atPath path: String, readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [String: Any]? {
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        
        return json as? [String: Any]
    }
    /// - Parameters:
    ///   - path: JSON file path.
    ///   - options: JSONSerialization reading options.
    /// - Returns: Optional dictionary.
    /// - Throws: Throws any errors thrown by Data creation or JSON serialization.
    func jsonArrayFromFile( atPath path: String, readingOptions: JSONSerialization.ReadingOptions = .allowFragments) throws -> [[String: Any]]? {
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
        
        return json as? [[String: Any]]
    }
    
    /// Returns the URL of the file given a name
    ///
    /// - Parameter fileName: The file name of the file + extension
    /// - Returns: The URL as String
    static func getFileURL(_ fileName: String) -> String? {
        let fileURL = FileManager().urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first
        return (fileURL?.appendingPathComponent(fileName).path)
    }
    
}
