//
//  ListMoviesCollectionPresenterProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol ListMoviesCollectionPresenterProtocol {
    func didSelect(movie: Movie?)
    func getNumberOfColumns() -> CGFloat
    func getRightNavigationItems() -> [UIBarButtonItem]
    func loadMovies(page: Int)
    func shouldLoadMoreMovies(totalMovies: Int, index: Int, numberOfColumns: CGFloat, willFetch: Bool) -> Bool
    func updateFlowLayout(numberOfColumns: CGFloat, flowLayout: UICollectionViewFlowLayout)
}
