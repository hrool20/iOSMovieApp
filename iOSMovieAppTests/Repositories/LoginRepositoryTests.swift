//
//  LoginRepositoryTests.swift
//  iOSMovieAppTests
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import XCTest
@testable import Movie_App

class LoginRepositoryTests: XCTestCase {
    private let timeout: TimeInterval = 30.0
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testClearToken() throws {
        let storeHandler = RouterMock.shared.keychainHandler
        XCTAssertTrue(storeHandler.remove(from: Constants.Keys.TOKEN))
    }
    
    func testSuccessfulSignInResponse() throws {
        let email = "peruapps0@peruapps.com"
        let password = "password0"
        let expectation = self.expectation(description: "Token should be saved before half minute")
        
        let storeHandler = RouterMock.shared.keychainHandler
        let loginRepository = RouterMock.shared.loginRepository
        loginRepository.signIn(email: email,
                               password: password,
        success: {
            let token = storeHandler.string(from: Constants.Keys.TOKEN)
            XCTAssertNotNil(token, "Token is nil")
            XCTAssertNotEqual(token, "", "Token is empty")
            expectation.fulfill()
        }) { (error) in
            XCTFail("Response should be successful")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout) { (error) in
            guard let error = error else { return }
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func testFailedSignInResponse() throws {
        let email = "user"
        let password = "user"
        let expectation = self.expectation(description: "Token should be saved before half minute")
        
        let loginRepository = RouterMock.shared.loginRepository
        loginRepository.signIn(email: email,
                               password: password,
        success: {
            XCTFail("Response should fail")
            expectation.fulfill()
        }) { (error) in
            XCTAssertNotNil(error, "Error message is nil")
            XCTAssertNotEqual(error, "", "Error message is empty")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout) { (error) in
            guard let error = error else { return }
            print("Error: \(error.localizedDescription)")
        }
    }

}
