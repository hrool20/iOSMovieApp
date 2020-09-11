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
    var keychainHandler: StoreHandlerProtocol!
    var userDefaultsHandler: StoreHandlerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let isTokenSaved: Bool
        
        if userDefaultsHandler.bool(from: Constants.Keys.WAS_FIRST_OPEN),
            let _ = keychainHandler.string(from: Constants.Keys.TOKEN) {
            isTokenSaved = true
        } else {
            isTokenSaved = false
            _ = keychainHandler.remove(from: Constants.Keys.TOKEN)
            userDefaultsHandler.save(value: true, to: Constants.Keys.WAS_FIRST_OPEN)
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

}
