//
//  UIViewExtension.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

extension UIView: ShimmerHandlerProtocol {
    private static var NIBName: String {
        return String(describing: self)
    }
    
    static func get(owner: Any? = nil) -> Self {
        guard let view = Bundle.main.loadNibNamed(NIBName, owner: owner, options: nil)?[0] as? Self else {
            fatalError("This should never happen")
        }
        return view
    }
    
    static func getNIB() -> UINib {
        return UINib(nibName: self.NIBName, bundle: nil)
    }
    
    // MARK: - ShimmerViewHandler
    func hideShimmerEffect() {
        self.hideSkeleton(reloadDataAfter: true, transition: transitionDurationHiding)
    }
    
    func showShimmerEffect(firstColor: UIColor, secondColor: UIColor?, andDuration duration: Double) {
        let gradient = SkeletonGradient(baseColor: firstColor, secondaryColor: secondColor)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: animationDirection, duration: duration)
        self.isSkeletonable = true
        self.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: transitionDurationShowing)
    }
}
