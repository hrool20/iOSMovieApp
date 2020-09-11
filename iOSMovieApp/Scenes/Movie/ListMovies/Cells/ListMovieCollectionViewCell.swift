//
//  ListMovieCollectionViewCell.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import UIKit

class ListMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    static var reuseIdentifier: String? {
        return "listMovieViewCell"
    }
    var movie: Movie! {
        didSet {
            guard movie != nil else {
                return
            }
            
            endShimmerEffect()
            
            if let url = URL(string: movie.imageUrl) {
                movieImageView.setImage(with: url) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }
            movieNameLabel.text = movie.title
        }
    }
    override var isSelected: Bool {
        didSet {
            let time = 0.2
            UIView.animate(withDuration: time,
            animations: {
                self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            }) { (finished) in
                UIView.animate(withDuration: time) {
                    self.transform = .identity
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        startShimmerEffect()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [self, movieImageView].forEach { (view) in
            view?.layer.cornerRadius = 10
        }
        layer.masksToBounds = false
        layer.cornerRadius = bounds.height / 15
        layer.shadowRadius = 4.0
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 0.4
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        startShimmerEffect()
    }
    
    private func startShimmerEffect() {
        [movieNameLabel].forEach { (view) in
            view?.isHidden = true
        }
        [movieImageView].forEach { (view) in
            view?.showShimmerEffect()
        }
    }
    
    private func endShimmerEffect() {
        [movieNameLabel].forEach { (view) in
            view?.isHidden = false
        }
        [movieImageView].forEach { (view) in
            view?.hideShimmerEffect()
        }
    }
    
    func willDisplay() {
        alpha = 0.0
        transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.4,
                       delay: 0.0,
                       options: [.curveEaseIn, .allowUserInteraction],
        animations: {
            self.alpha = 1.0
            self.transform = .identity
        }) { (finished) in
        }
    }

}
