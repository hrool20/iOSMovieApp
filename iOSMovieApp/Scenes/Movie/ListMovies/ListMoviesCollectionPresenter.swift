//
//  ListMoviesCollectionPresenter.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class ListMoviesCollectionPresenter: ListMoviesCollectionPresenterProtocol {
    private let keychainHandler: StoreHandlerProtocol
    private let movieRepository: MovieRepository
    private let view: ListMoviesCollectionViewControllerProtocol
    
    init(keychainHandler: StoreHandlerProtocol, movieRepository: MovieRepository, view: ListMoviesCollectionViewControllerProtocol) {
        self.keychainHandler = keychainHandler
        self.movieRepository = movieRepository
        self.view = view
    }
    
    func didSelect(movie: Movie?) {
        guard let movie = movie else {
            return
        }
        view.showMovieDetail(movie)

    }
    
    func getNumberOfColumns() -> CGFloat {
        return (UIScreen.main.bounds.width < UIScreen.main.bounds.height) ? 3.0 : 5.0
    }
    
    func getRightNavigationItems() -> [UIBarButtonItem] {
        let size = CGSize(width: 25, height: 25)
        
        let signOutItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout").resizeImage(with: size), style: .plain, target: self, action: #selector(didSignOut))
        return [
            signOutItem
        ]
    }
    
    @objc private func didSignOut() {
        view.showQuestion(.alert, message: Constants.Localizable.SIGN_OUT_QUESTION) { [weak self] (isSuccessful) in
            guard let self = self, isSuccessful else { return }
            
            _ = self.keychainHandler.remove(from: Constants.Keys.TOKEN)
            self.view.showSignIn()
        }
    }
    
    func loadMovies(page: Int) {
        movieRepository.getMovies(page: page, success: { [weak self] (movies) in
            guard let self = self else { return }
            
            self.view.loadData((!movies.isEmpty) ? true : false, movies)
        }) { [weak self] (error) in
            guard let self = self else { return }
            
            self.view.loadData(false, [])
            self.view.show(.alert, message: Constants.Localizable.DEFAULT_ERROR_MESSAGE)
        }
    }
    
    func shouldLoadMoreMovies(totalMovies: Int, index: Int, numberOfColumns: CGFloat, willFetch: Bool) -> Bool {
        guard willFetch && index == totalMovies - Int(numberOfColumns) else {
            return false
        }
        return true
    }
    
    func updateFlowLayout(numberOfColumns: CGFloat, flowLayout: UICollectionViewFlowLayout) {
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        let availableWidth = UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((numberOfColumns - 1) * flowLayout.minimumInteritemSpacing)
        let size = availableWidth / numberOfColumns
        flowLayout.itemSize = CGSize(width: size.rounded(.towardZero), height: 200)

    }
}
