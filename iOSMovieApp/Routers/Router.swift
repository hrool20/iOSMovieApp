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
    
    func getDefaultNavigation(rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
    
    func getListMovies() -> UIViewController {
        let viewController = ListMoviesCollectionViewController.get()
        return viewController
    }
    
    func getSignIn() -> UIViewController {
        let viewController = SignInViewController.get()
        return viewController
    }
}
