//  ComandaUITests.swift
//  ComandaUITests
//
//  Created by Amanda Campos on 01/04/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import XCTest

class ComandaUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        
    }
    
}
