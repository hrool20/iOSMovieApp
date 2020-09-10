//
//  UIViewControllerExtension.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController: AlertHandlerProtocol, HUDHandlerProtocol {
    private static var NIBName: String {
        return String(describing: self)
    }
    
    static func get(with bundle: Bundle? = nil) -> Self {
        return Self(nibName: NIBName, bundle: bundle)
    }
    
    // MARK: Transition between viewControllers
    func start(_ transition: UIView.AnimationOptions, to viewController: UIViewController, duration: TimeInterval = 0.6) {
        guard let window = UIApplication.shared.keyWindow else {
            fatalError()
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: duration, options: transition, animations: nil, completion: nil)
    }
    
    // MARK: AlertHandlerProtocol
    func show(_ style: UIAlertController.Style, title: String?, message: String, closure: @escaping (() -> Void)) {
        let alertController = UIAlertController(title: title ?? Constants.Localizable.APP_NAME, message: message, preferredStyle: style)
        let okAction = UIAlertAction(title: Constants.Localizable.OK, style: .default) { (_) in
            closure()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, title: String?, message: String, yes okTitle: String?, no cancelTitle: String?, closure: @escaping ((Bool) -> Void)) {
        let alertController = UIAlertController(title: title ?? Constants.Localizable.APP_NAME, message: message, preferredStyle: style)
        let yesAction = UIAlertAction(title: okTitle ?? Constants.Localizable.YES, style: .destructive) { (_) in
            closure(true)
        }
        let noAction = UIAlertAction(title: cancelTitle ?? Constants.Localizable.NO, style: .default) { (_) in
            closure(false)
        }
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        alertController.preferredAction = noAction
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: HUDHandlerProtocol
    var isHUDVisible: Bool {
        get {
            return SVProgressHUD.isVisible()
        }
    }
    
    func endProgress() {
        if isHUDVisible {
            SVProgressHUD.dismiss()
        }
    }
    
    func startProgress(message: String?, with maskType: SVProgressHUDMaskType) {
        SVProgressHUD.setDefaultMaskType(maskType)
        SVProgressHUD.show(withStatus: message)
    }
}
