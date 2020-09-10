//
//  ModelProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ModelProtocol: Codable {
    init(fromJSONObject jsonObject: JSON)
}
extension ModelProtocol {
    static func buildCollection(fromJSONArray jsonArray: [JSON]) -> [Self] {
        return jsonArray.map { (jsonObject) -> Self in
            Self(fromJSONObject: jsonObject)
        }
    }
}
