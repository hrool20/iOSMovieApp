//
//  SignInViewControllerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol SignInViewControllerProtocol: AlertHandlerProtocol, HUDHandlerProtocol {
    func showListMovies()
}
