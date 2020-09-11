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
    private var gradientLayer: CAGradientLayer!
    var movie: Movie!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.Localizable.MOVIE_DETAIL
        
        gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0.35, 1.1]
        movieImageView.layer.insertSublayer(gradientLayer, at: 0)
        
        scrollView.delegate = self
        if let url = URL(string: movie.imageUrl) {
            movieImageView.setImage(with: url)
        }
        movieNameLabel.text = movie.title
        descriptionTextView.text = movie.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        updateTitleColor(with: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.topItem?.backBarButtonItem = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.titleTextAttributes = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.tintColor?.cgColor ?? UIColor.clear.cgColor
        ]
        gradientLayer.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: movieImageView.bounds.height))
        movieImageView.layer.cornerRadius = movieImageView.bounds.width / 20
        movieImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func updateTitleColor(with alpha: CGFloat) {
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white.withAlphaComponent(alpha)
        ]
    }

}
extension ShowMovieDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let heightLeft: CGFloat = (movieImageView.bounds.height - scrollView.contentOffset.y > 0) ? movieImageView.bounds.height - scrollView.contentOffset.y : 0
        let beginning: CGFloat = movieImageView.bounds.height / 2.5
        
        let alpha: CGFloat
        if heightLeft < beginning {
            alpha = heightLeft / beginning
        } else if heightLeft == 0 {
            alpha = 0
        } else {
            alpha = 1
        }
        updateTitleColor(with: alpha)
    }
}
