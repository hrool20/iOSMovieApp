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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
