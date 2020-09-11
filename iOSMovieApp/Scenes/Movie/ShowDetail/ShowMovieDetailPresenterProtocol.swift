//
//  ShowMovieDetailPresenterProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

protocol ShowMovieDetailPresenterProtocol {
    func getGradientLayer() -> CAGradientLayer
    func getGradientLayerColors() -> [CGColor]
    func updateTitleColor(headerHeight: CGFloat?, scrollViewY: CGFloat?)
}
