//
//  ListMoviesCollectionViewController.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class ListMoviesCollectionViewController: UICollectionViewController {
    
    private var movies: [Movie]?
    private var reuseIdentifier: String!
    private var numberOfColumns: CGFloat!
    private var page: Int!
    private var willFetch: Bool!
    private var flowLayout: UICollectionViewFlowLayout!
    var listMoviesPresenter: ListMoviesCollectionPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.Localizable.MOVIES
        
        reuseIdentifier = ListMovieCollectionViewCell.reuseIdentifier
        numberOfColumns = listMoviesPresenter.getNumberOfColumns()
        page = 1
        willFetch = true
        flowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(ListMovieCollectionViewCell.getNIB(), forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.setRightBarButtonItems(listMoviesPresenter.getRightNavigationItems(), animated: true)
        listMoviesPresenter.updateFlowLayout(numberOfColumns: numberOfColumns, flowLayout: flowLayout)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        listMoviesPresenter.loadMovies(page: page)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        numberOfColumns = listMoviesPresenter.getNumberOfColumns()
        listMoviesPresenter.updateFlowLayout(numberOfColumns: numberOfColumns, flowLayout: flowLayout)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 9
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListMovieCollectionViewCell
        if let movie = movies?[indexPath.row] {
            cell.movie = movie
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        listMoviesPresenter.didSelect(movie: movies?[indexPath.row])
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard listMoviesPresenter.shouldLoadMoreMovies(totalMovies: movies?.count ?? 0, index: indexPath.row, numberOfColumns: numberOfColumns, willFetch: willFetch) else {
            return
        }
        page += 1
        willFetch = false
        listMoviesPresenter.loadMovies(page: page)
    }

}
extension ListMoviesCollectionViewController: ListMoviesCollectionViewControllerProtocol {
    func loadData(_ willFetch: Bool, _ movies: [Movie]) {
        if self.movies == nil {
            self.movies = [Movie]()
        }
        self.willFetch = willFetch
        self.movies?.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    func showMovieDetail(_ movie: Movie) {
        let movieDetail = Router.shared.getMovieDetail(movie: movie)
        movieDetail.hidesBottomBarWhenPushed = true
        navigationController?.show(movieDetail, sender: nil)
    }
    
    func showSignIn() {
        let signIn = Router.shared.getDefaultNavigation(rootViewController: Router.shared.getSignIn())
        self.start([.transitionFlipFromRight], to: signIn)
    }
}
