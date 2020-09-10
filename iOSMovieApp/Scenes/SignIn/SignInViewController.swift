//
//  SignInViewController.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.placeholder = Constants.Localizable.EMAIL
        passwordTextField.placeholder = Constants.Localizable.PASSWORD
        signInButton.setTitle(Constants.Localizable.SIG_IN, for: .normal)
        
        emailTextField.text = "peruapps0@peruapps.com"
        passwordTextField.text = "password0"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoImageView.image = logoImageView.image?.withRenderingMode(.alwaysTemplate)
        logoImageView.tintColor = .black
    }

    @IBAction func didSignIn(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty else {
            show(.alert, message: Constants.Localizable.EMAIL_NOT_VALID)
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            show(.alert, message: Constants.Localizable.PASSWORD_NOT_VALID)
            return
        }
        
        startProgress()
        
        LoginRepository.shared.signIn(email: email,
                                      password: password,
        success: { [weak self] in
            guard let self = self else { return }
            
            self.endProgress()
            let listMovies = Router.shared.getListMovies()
            let navigationController = Router.shared.getDefaultNavigation(rootViewController: listMovies)
            self.start([.transitionFlipFromLeft], to: navigationController)
        }) { [weak self] (errorMessage) in
            self?.endProgress()
            
            self?.show(.alert, message: errorMessage)
        }
    }

}
