//
//  SplashPresenter.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class SplashPresenter: SplashPresenterProtocol {
    private let keychainHandler: StoreHandlerProtocol
    private let userDefaultsHandler: StoreHandlerProtocol
    private let view: SplashViewControllerProtocol
    
    init(keychainHandler: StoreHandlerProtocol, userDefaultsHandler: StoreHandlerProtocol, view: SplashViewControllerProtocol) {
        self.keychainHandler = keychainHandler
        self.userDefaultsHandler = userDefaultsHandler
        self.view = view
    }
    
    func starSplash() {
        let isTokenSaved: Bool
        
        if userDefaultsHandler.bool(from: Constants.Keys.WAS_FIRST_OPEN),
            let _ = keychainHandler.string(from: Constants.Keys.TOKEN) {
            isTokenSaved = true
        } else {
            isTokenSaved = false
            _ = keychainHandler.remove(from: Constants.Keys.TOKEN)
            userDefaultsHandler.save(value: true, to: Constants.Keys.WAS_FIRST_OPEN)
        }
        
        view.startActivityIndicator()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) { [weak self] in
            guard let self = self else { return }
            
            self.view.stopActivityIndicator()
            let viewController: UIViewController
            if isTokenSaved {
                viewController = Router.shared.getListMovies()
            } else {
                viewController = Router.shared.getSignIn()
            }
            let navigationController = Router.shared.getDefaultNavigation(rootViewController: viewController)
            self.view.showRootViewController(navigationController)
        }
    }
}
