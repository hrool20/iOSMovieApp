//
//  RouterMock.swift
//  iOSMovieAppTests
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
@testable import Movie_App

class RouterMock {
    static let shared = RouterMock()
    // Handlers
    let keychainHandler: StoreHandlerProtocol
    let userDefaultsHandler: StoreHandlerProtocol
    // Repositories
    let loginRepository: LoginRepository
    let movieRepository: MovieRepository
    
    init() {
        let suiteName = "MovieAppTest"
        keychainHandler = KeychainHandler(suiteName: suiteName)
        userDefaultsHandler = UserDefaultsHandler(suiteName: suiteName)
        
        loginRepository = LoginRepository(keychainHandler: keychainHandler)
        movieRepository = MovieRepository(keychainHandler: keychainHandler)
    }
}
