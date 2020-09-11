//
//  SplashViewController.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var splashPresenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splashPresenter.starSplash()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoImageView.image = logoImageView.image?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = .tintColor
    }

}
extension SplashViewController: SplashViewControllerProtocol {
    func showRootViewController(_ viewController: UIViewController) {
        start([.transitionCrossDissolve], to: viewController)
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
