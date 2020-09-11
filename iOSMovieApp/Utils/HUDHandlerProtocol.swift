//
//  HUDHandlerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SVProgressHUD

protocol HUDHandlerProtocol {
    var isHUDVisible: Bool { get }
    func endProgress()
    func startProgress(message: String?, with maskType: SVProgressHUDMaskType)
}
extension HUDHandlerProtocol {
    func startProgress(message: String? = nil) {
        startProgress(message: message, with: .black)
    }
    
    func startProgress(with maskType: SVProgressHUDMaskType) {
        startProgress(message: nil, with: maskType)
    }
}
