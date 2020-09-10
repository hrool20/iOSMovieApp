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
    private var willFecth: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.Localizable.MOVIES
        
        reuseIdentifier = ListMovieCollectionViewCell.reuseIdentifier
        numberOfColumns = 3.0
        page = 1
        willFecth = true
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.register(ListMovieCollectionViewCell.getNIB(), forCellWithReuseIdentifier: reuseIdentifier)
        
        listMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
    }
    
    private func listMovies() {
        MovieRepository.shared.getMovies(page: page, success: { [weak self] (movies) in
            guard let self = self else { return }
            
            if self.movies == nil {
                self.movies = [Movie]()
            }
            self.willFecth = (!movies.isEmpty) ? true : false
            self.movies?.append(contentsOf: movies)
            self.collectionView.reloadData()
        }) { [weak self] (error) in
            guard let self = self else { return }
            
            if self.movies == nil {
                self.movies = []
            }
            self.willFecth = false
            self.show(.alert, message: Constants.Localizable.DEFAULT_ERROR_MESSAGE)
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ListMovieCollectionViewCell
        if let movie = movies?[indexPath.row] {
            cell.movie = movie
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movies?[indexPath.row] else {
            return
        }
        let movieDetail = Router.shared.getMovieDetail(movie: movie)
        movieDetail.hidesBottomBarWhenPushed = true
        navigationController?.show(movieDetail, sender: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let count = movies?.count ?? 0
        guard willFecth && indexPath.row == count - Int(numberOfColumns) else {
            return
        }
        page += 1
        willFecth = false
        listMovies()
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let availableWidth = UIScreen.main.bounds.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - ((numberOfColumns - 1) * flowLayout.minimumInteritemSpacing)
        let size = availableWidth / numberOfColumns
        return CGSize(width: size.rounded(.towardZero), height: 200)
    }
}
extension ListMoviesCollectionViewController: UICollectionViewDelegateFlowLayout {}
