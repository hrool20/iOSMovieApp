//
//  ListMoviesCollectionViewControllerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol ListMoviesCollectionViewControllerProtocol: AlertHandlerProtocol {
    func loadData(_ willFetch: Bool, _ movies: [Movie])
    func showMovieDetail(_ movie: Movie)
    func showSignIn()
}
