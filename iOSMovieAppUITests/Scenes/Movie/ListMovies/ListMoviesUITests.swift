//
//  ListMoviesUITests.swift
//  iOSMovieAppUITests
//
//  Created by Hugo Andres Rosado on 9/11/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import XCTest

class ListMoviesUITests: XCTestCase {

    private let app: XCUIApplication = XCUIApplication()
    private let timeout: TimeInterval = 5.0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignOut() throws {
        let moviesNavigationBar = app.navigationBars["Movies"]
        let signOutBarButtonItem = moviesNavigationBar.children(matching: .button).element
        let signOutAlert = app.alerts["Movie App"].scrollViews.otherElements
        
        // MARK: First Way
        XCTAssertTrue(moviesNavigationBar.waitForExistence(timeout: timeout))
        XCTAssertTrue(moviesNavigationBar.exists)

        signOutBarButtonItem.tap()
        signOutAlert.buttons["No"].tap()
        XCTAssertTrue(moviesNavigationBar.exists)

        signOutBarButtonItem.tap()
        signOutAlert.buttons["Yes"].tap()
        XCTAssertFalse(moviesNavigationBar.exists)
    }

}
