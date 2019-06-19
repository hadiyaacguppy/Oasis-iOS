//
// Created by Wassim on 2019-06-19.
// Copyright (c) 2019 Tedmob. All rights reserved.
//

import XCTest
@testable import Base_Project

class StringExtensions_Tests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    private func testURLConversionError() {
        print("eqweqwe")
        assert("htt://gooeq.id".asURL() != nil , "THIS IS GOOD")
    }

    private func testURLConversionValid() {
        assert("https://google.com".asURL() != nil)
    }
}
