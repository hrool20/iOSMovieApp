//
//  ShowMovieDetailViewController.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class ShowMovieDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var descriptionTextView: UITextView!
    private var navigationBarTintColor: UIColor?
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.Localizable.MOVIE_DETAIL
        
        navigationBarTintColor = navigationController?.navigationBar.tintColor
        
        if let url = URL(string: movie.imageUrl) {
            movieImageView.setImage(with: url)
        }
        movieNameLabel.text = movie.title
        descriptionTextView.text = movie.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navigationController?.navigationBar.barStyle = .blackTranslucent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
        navigationController?.navigationBar.tintColor = navigationBarTintColor
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = nil
        navigationController?.navigationBar.barStyle = .default
    }

}
