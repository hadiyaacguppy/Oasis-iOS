//
//  SessionRepositoryTests.swift
//  SessionRepositoryTests
//
//  Created by Wassim on 7/1/19.
//  Copyright © 2019 Tedmob. All rights reserved.
//

import XCTest
@testable import SessionRepository
class SessionRepositoryTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSavingUser(){
        let user = User()
        SessionRepository().currentUser = user
        assert(SessionRepository().currentUser != nil )
    }
    
    func testSavingUserAttributes(){
        let user = User()
        user.token = "123"
        SessionRepository().currentUser = user
        assert(SessionRepository().currentUser?.token != nil)
        assert(SessionRepository().currentUser!.token! == "123")
    }
    
    func testDeleteUser(){
        let user = User()
        SessionRepository().currentUser = user
        SessionRepository().currentUser = nil
        assert(SessionRepository().currentUser == nil )
    }
    
    func testTokenWithoutUser(){
        SessionRepository().currentUser = nil
        assert(SessionRepository().currentUser == nil )
        
        SessionRepository().token = "123"
        
        assert(SessionRepository().currentUser != nil )
        assert(SessionRepository().currentUser?.token != nil )
        assert(SessionRepository().token != nil )
        assert(SessionRepository().token == "123" )
        assert(SessionRepository().currentUser?.token == "123" )
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            testSavingUser()
            // Put the code you want to measure the time of here.
        }
    }
    
}
