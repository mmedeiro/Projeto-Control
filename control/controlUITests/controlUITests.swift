//
//  controlUITests.swift
//  controlUITests
//
//  Created by Amanda Campos on 04/02/16.
//  Copyright © 2016 Amanda Campos. All rights reserved.
//

import XCTest

class controlUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
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
        
        let app = XCUIApplication()
        
        snapshot("joaolindo")
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Orçamento Limitado"].tap()
        
        snapshot("fian")
        
        let collectionViewsQuery = app.alerts.collectionViews
        
        snapshot("adasda")
        collectionViewsQuery.textFields["Valor"]
        collectionViewsQuery.buttons["Salvar"].tap()
        app.navigationBars["Orçamento Limitado"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        tablesQuery.staticTexts["Lista de gastos"].tap()
        
        snapshot("fsifns")
    }
    
}
