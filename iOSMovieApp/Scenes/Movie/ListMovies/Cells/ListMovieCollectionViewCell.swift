//
//  ListMovieCollectionViewCell.swift
//  iOSMovieApp
//
//  Created by Hugo Andres Rosado on 9/9/20.
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
            
            if let url = URL(string: movie.imageUrl) {
                movieImageView.setImage(with: url) { [weak self] (_) in
                    self?.layoutSubviews()
                }
            }
            movieNameLabel.text = movie.title
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        movieImageView.layer.cornerRadius = 10
    }

}
