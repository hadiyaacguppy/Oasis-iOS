//
//  String+Extensions.swift
//  Base-Project
//
//  Created by Wassim Seifeddine on 12/6/17.
//  Copyright © 2017 Tedmob. All rights reserved.
//

import UIKit

extension String  :  Error{}

extension String {
    
    
    func asURL() -> URL? {
        return URL(string: self)
        
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
        
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
    var toAttributed : NSAttributedString {
        return NSAttributedString(string: self)
    }

}

extension Optional where Wrapped == String{
    
    /// This function will try to render the html in string with the specified font without losing the symbolic traits in the HTML.
    ///
    /// - Parameter fontToApply: The font to be applied on the html string.
    /// - Returns: Attributed string with the font specified. if no font specified, the attributed string with the defualt html font will be returned.
    func applyHtml(withFont fontToApply : UIFont?) -> NSMutableAttributedString?{
        
        //Convert to data
        guard let data = self?.data(using: .utf8, allowLossyConversion: true) else {
            return nil
        }
        
        //Create NSMutableAttriburedString form the data , if fails a nil will be returned
        guard let attr = try? NSMutableAttributedString(data: data,
                                                        options: [.documentType: NSAttributedString.DocumentType.html],
                                                        documentAttributes: nil
            ) else {
                return nil
        }
        
        //If there is no font to be applied the attributed string will be returned
        guard fontToApply != nil else{            
            return attr
        }
        
        //Ok, now in order to apply any font without losing the traits ,i will iterate through each range of the fontAttributedStringKey,
        //and copy the traits from the fetched font in the current range to apply it on the new created font using copySymbolicTraits function
        attr.enumerateAttribute(.font,
                                in: NSMakeRange(0,attr.length),
                                options: []) { (value, range, stop) in
                                    let originalFont = value as! UIFont
                                    if let newFont = Utilities.Font.copySymbolicTraits(from: originalFont, to: fontToApply!){
                                        attr.addAttribute(.font, value: newFont, range: range)
                                    }
        }
        return attr
    }
}
