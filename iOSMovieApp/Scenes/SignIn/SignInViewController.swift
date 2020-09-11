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
    var signInPresenter: SignInPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.placeholder = Constants.Localizable.EMAIL
        passwordTextField.placeholder = Constants.Localizable.PASSWORD
        signInButton.setTitle(Constants.Localizable.SIG_IN, for: .normal)
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
        logoImageView.tintColor = .tintColor
        signInButton.layer.cornerRadius = signInButton.bounds.height / 2
    }

    @IBAction func didSignIn(_ sender: UIButton) {
        signInPresenter.signIn(email: emailTextField.text, password: passwordTextField.text)
    }

}
extension SignInViewController: SignInViewControllerProtocol {
    func showListMovies() {
        let listMovies = Router.shared.getListMovies()
        let navigationController = Router.shared.getDefaultNavigation(rootViewController: listMovies)
        start([.transitionFlipFromLeft], to: navigationController)
    }
}
