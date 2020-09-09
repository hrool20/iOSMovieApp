//
//  SignInViewController.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.placeholder = Constants.Localizable.EMAIL
        passwordTextField.placeholder = Constants.Localizable.PASSWORD
        signInButton.setTitle(Constants.Localizable.SIG_IN, for: .normal)
    }

    @IBAction func didSignIn(_ sender: UIButton) {
    }

}
