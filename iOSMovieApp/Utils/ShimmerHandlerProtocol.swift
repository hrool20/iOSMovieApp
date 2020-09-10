//
//  ShimmerHandlerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SkeletonView

protocol ShimmerHandlerProtocol {
    func hideShimmerEffect()
    func showShimmerEffect(firstColor: UIColor, secondColor: UIColor?, andDuration duration: Double)
}
extension ShimmerHandlerProtocol {
    var animationDirection: GradientDirection {
        return .leftRight
    }
    fileprivate var animationDuration: Double {
        return 1.0
    }
    fileprivate var defaultFirstColor: UIColor {
        return .secondDarkColor ?? .gray
    }
    fileprivate var defaultSecondColor: UIColor? {
        return nil
    }
    var transitionDurationShowing: SkeletonTransitionStyle {
        return .crossDissolve(0.0)
    }
    var transitionDurationHiding: SkeletonTransitionStyle {
        return .crossDissolve(0.15)
    }
    
    func showShimmerEffect(WithDuration duration: Double = 1.0) {
        self.showShimmerEffect(firstColor: defaultFirstColor, secondColor: defaultSecondColor, andDuration: duration)
    }

    func showShimmerEffect(firstColor: UIColor, secondColor: UIColor? = nil) {
        self.showShimmerEffect(firstColor: firstColor, secondColor: secondColor, andDuration: animationDuration)
    }
}
