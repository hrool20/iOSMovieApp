//
//  Router.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    // Handlers
    private let keychainHandler: StoreHandlerProtocol
    private let userDefaultsHandler: StoreHandlerProtocol
    // Repositories
    private var loginRepository: LoginRepository
    private var movieRepository: MovieRepository
    
    init() {
        keychainHandler = KeychainHandler()
        userDefaultsHandler = UserDefaultsHandler()
        
        loginRepository = LoginRepository(keychainHandler: keychainHandler)
        movieRepository = MovieRepository(keychainHandler: keychainHandler)
    }
    
    func getDefaultNavigation(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = .tintColor
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.textColor ?? UIColor.black
        ]
        return navigationController
    }
    
    func getListMovies() -> UIViewController {
        let viewController = ListMoviesCollectionViewController.get()
        viewController.movieRepository = movieRepository
        viewController.keychainHandler = keychainHandler
        return viewController
    }
    
    func getMovieDetail(movie: Movie) -> UIViewController {
        let viewController = ShowMovieDetailViewController.get()
        viewController.movie = movie
        return viewController
    }
    
    func getSignIn() -> UIViewController {
        let viewController = SignInViewController.get()
        viewController.loginRepository = loginRepository
        return viewController
    }
    
    func getSplash() -> UIViewController {
        let viewController = SplashViewController.get()
        viewController.keychainHandler = keychainHandler
        viewController.userDefaultsHandler = userDefaultsHandler
        return viewController
    }
}
