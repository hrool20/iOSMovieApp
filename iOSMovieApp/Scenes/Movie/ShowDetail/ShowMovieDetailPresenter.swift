//
//  ShowMovieDetailPresenter.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit

final class ShowMovieDetailPresenter: ShowMovieDetailPresenterProtocol {
    private let view: ShowMovieDetailViewControllerProtocol
    
    init(view: ShowMovieDetailViewControllerProtocol) {
        self.view = view
    }
    
    func getGradientLayer() -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.locations = [0.35, 1.1]
        return gradientLayer
    }
    
    func getGradientLayerColors() -> [CGColor] {
        return [
            UIColor.clear.cgColor,
            UIColor.tintColor?.cgColor ?? UIColor.clear.cgColor
        ]
    }
    
    func updateTitleColor(headerHeight: CGFloat?, scrollViewY: CGFloat?) {
        guard let headerHeight = headerHeight, let scrollViewY = scrollViewY else {
            view.updateTitleColor(1.0)
            return
        }
        let heightLeft: CGFloat = (headerHeight - scrollViewY > 0) ? headerHeight - scrollViewY : 0
        let beginning: CGFloat = headerHeight / 2.5
        
        let alpha: CGFloat
        if heightLeft < beginning {
            alpha = heightLeft / beginning
        } else if heightLeft == 0 {
            alpha = 0
        } else {
            alpha = 1
        }
        view.updateTitleColor(alpha)
    }
}
