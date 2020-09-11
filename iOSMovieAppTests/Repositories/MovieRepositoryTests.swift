//
//  MovieRepositoryTests.swift
//  iOSMovieAppTests
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import XCTest
@testable import Movie_App

class MovieRepositoryTests: XCTestCase {
    private let timeout: TimeInterval = 60.0
    
    override func setUpWithError() throws {
        let storeHandler = RouterMock.shared.keychainHandler
        let token = storeHandler.string(from: Constants.Keys.TOKEN)
        XCTAssertNotNil(token, "Token is nil")
        XCTAssertNotEqual(token, "", "Token is empty")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSuccessfulListMoviesResponse() throws {
        let page = 1
        let expectation = self.expectation(description: "Movie array should not be empty")
        
        let movieRepository = RouterMock.shared.movieRepository
        
        movieRepository.getMovies(page: page, success: { (movies) in
            XCTAssertNotEqual(movies, [], "Movies array is empty")
            expectation.fulfill()
        }) { (error) in
            XCTFail("Response should be successful")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }
    
    func testFailedListMoviesResponse() throws {
        let page = 4
        let expectation = self.expectation(description: "Movie array should be empty")
        
        let movieRepository = RouterMock.shared.movieRepository
        
        movieRepository.getMovies(page: page, success: { (movies) in
            XCTAssertEqual(movies, [], "Movies array is not empty")
            expectation.fulfill()
        }) { (error) in
            XCTFail("Response should be successful")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout, handler: nil)
    }

}
