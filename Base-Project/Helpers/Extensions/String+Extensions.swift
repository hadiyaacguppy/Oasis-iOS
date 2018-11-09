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
    func validate(withExpression expr : InputValidationExpression) -> Bool{
        let test = NSPredicate(format:"SELF MATCHES %@", expr.rawValue)
        return test.evaluate(with: self)
    }
    
    
    /// This function will return the id of any valid youtube link
    ///
    /// - Returns: Video Id
    mutating
    func getYoutubeVideoId()
        -> String? {
            //Step 1: First remove the spaces if exist, since the url will not be valid
            self = self.trimmingCharacters(in: .whitespaces)
            /* Step 2:
             Here we get the component of the given URL, it's GREAT in Lebanese in how it works!read about it.
             First we try to get the queryItems
             For examples :
             http://www.youtube.com/watch?v=XXXXXXXXXXX the queryItems is v=XXXXXXXXXXX (after the `?` question mark)
             http://www.youtube.com/watch?v=XXXXXXXXXXX&feature=youtu.be the queryItems are v=XXXXXXXXXXX and feature=youtu.be
             */
            
            /*
             Step 3:
             get the first item where the item name is v, youtube videos start with 'v' letter before the id
             */
            
            /*
             Step 4:
             If this returned nil this mean that the url given is short url
             so to get the id, it will be in the path after back slah "\"
             */
            
            //That's it.:)
            guard let value = URLComponents(string: self)?
                .queryItems?
                .first(where: { $0.name == "v" })?
                .value else{
                    return URLComponents(string: self)?
                        .path
                        .replacingOccurrences(of: "/", with: "")
            }
            return value
    }
    public func truncated(limit: Int) -> String {
        if self.count > limit {
            var truncatedString = self[0..<limit]
            truncatedString = truncatedString.appending("...")
            return truncatedString
        }
        return self
    }
    
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    var wordCount : Int {
        let range = startIndex..<endIndex
        var count = 0
        
        self.enumerateSubstrings(in: range, options: .byWords) { (word, _, _, _) in
            if word != nil { count += 1 }
        }
        
        return count
    }
    public var base64Encoded: String? {
        let plainData = data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    public var hasNumbers: Bool {
        return rangeOfCharacter(from: .decimalDigits, options: .literal, range: nil) != nil
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
