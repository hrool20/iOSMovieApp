//
//  Router.swift
//  iOSMovieApp
//
//  Created by Hugo Andres Rosado on 9/9/20.
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

class Router {
    static let shared = Router()
    
    func getSignIn() -> UIViewController {
        let viewController = SignInViewController.get()
        return viewController
    }
}
