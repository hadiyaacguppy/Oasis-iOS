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
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    /// Easy access to the count of characters
    var length: Int {
        return characters.count
    }
    
    /// Compares 2 strings without case sensitivity
    ///
    /// - parameter otherString: The other string to compare
    ///
    /// - returns: true if they are the same. false otherwise
    func inSensitiveCompare(otherString : String) ->Bool {
        return self.caseInsensitiveCompare(otherString) == ComparisonResult.orderedSame
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8),
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
