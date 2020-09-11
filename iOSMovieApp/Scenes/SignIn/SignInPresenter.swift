//
//  SignInPresenter.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class SignInPresenter: SignInPresenterProtocol {
    private let loginRepository: LoginRepository
    private let view: SignInViewControllerProtocol
    
    init(loginRepository: LoginRepository, view: SignInViewControllerProtocol) {
        self.loginRepository = loginRepository
        self.view = view
    }
    
    func signIn(email: String?, password: String?) {
        guard let email = email, !email.isEmpty else {
            view.show(.alert, message: Constants.Localizable.EMAIL_NOT_VALID)
            return
        }
        guard let password = password, !password.isEmpty else {
            view.show(.alert, message: Constants.Localizable.PASSWORD_NOT_VALID)
            return
        }
        
        view.startProgress()
        
        loginRepository.signIn(email: email, password: password, success: { [weak self] in
            guard let self = self else { return }
            
            self.view.endProgress()
            self.view.showListMovies()
        }) { [weak self] (errorMessage) in
            self?.view.endProgress()
            
            self?.view.show(.alert, message: errorMessage)
        }
    }
}
