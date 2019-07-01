//
//  CGRectExtensionsTests.swift
//  Base-ProjectTests
//
//  Created by Wassim on 7/1/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import Foundation
import XCTest
@testable import Base_Project


class CGRectExtensionsTests : XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAspectRatio(){
        let rect = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        assert(rect.aspectRatio == 1.0)
    }
}
