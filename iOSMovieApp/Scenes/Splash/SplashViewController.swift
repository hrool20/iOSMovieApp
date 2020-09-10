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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let isTokenSaved: Bool
        
        if UserDefaults.standard.bool(forKey: Constants.Keys.WAS_FIRST_OPEN),
            let _ = UserDefaults.standard.string(forKey: Constants.Keys.TOKEN) {
            isTokenSaved = true
        } else {
            isTokenSaved = false
            UserDefaults.standard.removeObject(forKey: Constants.Keys.TOKEN)
            UserDefaults.standard.set(true, forKey: Constants.Keys.WAS_FIRST_OPEN)
        }
        
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
            let viewController: UIViewController
            if isTokenSaved {
                viewController = Router.shared.getListMovies()
            } else {
                viewController = Router.shared.getSignIn()
            }
            
            let navigationController = Router.shared.getDefaultNavigation(rootViewController: viewController)
            self.start([.transitionCrossDissolve], to: navigationController)
        }
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
