//
//  AlertHandlerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol AlertHandlerProtocol {
    func show(_ style: UIAlertController.Style, title: String?, message: String, closure: @escaping(() -> Void))
    func showQuestion(_ style: UIAlertController.Style, title: String?, message: String, yes okTitle: String?, no cancelTitle: String?, closure: @escaping((Bool) -> Void))
}
extension AlertHandlerProtocol {
    func show(_ style: UIAlertController.Style, message: String, closure: (() -> Void)? = nil) {
        show(style, title: nil, message: message) {
            closure?()
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, title: String, message: String, closure: ((Bool) -> Void)? = nil) {
        showQuestion(style, title: title, message: message, yes: nil, no: nil) { (isSuccessful) in
            closure?(isSuccessful)
        }
    }
    
    func showQuestion(_ style: UIAlertController.Style, message: String, closure: @escaping((Bool) -> Void)) {
        showQuestion(style, title: nil, message: message, yes: nil, no: nil, closure: closure)
    }
    
    func showQuestion(_ style: UIAlertController.Style, message: String, yes okTitle: String, no cancelTitle: String, closure: ((Bool) -> Void)? = nil) {
        showQuestion(style, title: nil, message: message, yes: okTitle, no: cancelTitle) { (isSuccessful) in
            closure?(isSuccessful)
        }
    }
}
