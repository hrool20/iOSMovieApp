//
//  SplashViewControllerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol SplashViewControllerProtocol {
    func showRootViewController(_ viewController: UIViewController)
    func startActivityIndicator()
    func stopActivityIndicator()
}
