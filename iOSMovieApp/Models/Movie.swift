//
//  Movie.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SwiftyJSON

class Movie: ModelProtocol {
    var id: Int
    var title: String
    var description: String
    var imageUrl: String
    
    init(id: Int, title: String, description: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.description = description
        self.imageUrl = imageUrl
    }
    
    required convenience init(fromJSONObject jsonObject: JSON) {
        self.init(id: jsonObject["id"].intValue,
                  title: jsonObject["detail"]["title"].stringValue,
                  description: jsonObject["detail"]["description"].stringValue,
                  imageUrl: jsonObject["detail"]["img"].stringValue)
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
