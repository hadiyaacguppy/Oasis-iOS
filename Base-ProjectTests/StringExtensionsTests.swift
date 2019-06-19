//
// Created by Wassim on 2019-06-19.
// Copyright (c) 2019 Tedmob. All rights reserved.
//

import Foundation
import XCTest
@testable import Base_Project

class StringExtensionTests : XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAsURLExtensions(){
        let goodURL = "https://google.com"
        
        assert(goodURL.asURL() != nil , "URL is valid")
    
    }
    func testQueryValue(){
        let url = "https://www.youtube.com/results?search_query=search&page=&utm_source=opensearch"
        assert(url.queryValue(for: "search_query") == "search")
        assert(url.queryValue(for: "page") == "")
        assert(url.queryValue(for: "utm_source") == "opensearch")
        assert(url.queryValue(for: "doesnotexist") == nil)
    }
    
    func testCaseInSEnsitiveCompare() {
        let strOne = "HELlO"
        let strTWo = "hello"
        let notRelatedString = "hello2"
        assert(strOne.inSensitiveCompare(otherString: strTWo) == true)
        assert(strOne.inSensitiveCompare(otherString: notRelatedString) == false)
    }
    
    func testGetYoutubeVideoID(){
        let youtubeURL = "https://www.youtube.com/watch?v=F9hQkCAdwrg"
        assert(youtubeURL.getYoutubeVideoId() != nil)
        assert(youtubeURL.getYoutubeVideoId() == "F9hQkCAdwrg")
    }
    
    func testWordCount(){
        let paragraph = "iOS Develpoment is Good. TEDMOB is GOOD"
        
        
        assert(paragraph.wordCount == 7 )
        
    }
    
}
