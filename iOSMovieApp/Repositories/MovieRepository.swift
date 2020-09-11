//
//  MovieRepository.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

final class MovieRepository {
    private let keychainHandler: StoreHandlerProtocol
    
    init(keychainHandler: StoreHandlerProtocol) {
        self.keychainHandler = keychainHandler
    }
    
    func getMovies(page: Int, success: @escaping([Movie]) -> Void, failure: @escaping(String) -> Void) {
        let parameters: [String: Any] = [
            "page": page
        ]
        let headers: [String: String] = [
            "Accept": "application/json",
            "Authorization": "Bearer \(keychainHandler.string(from: Constants.Keys.TOKEN) ?? "")"
        ]
        
        ResponseHelper.GET(with: .url,
                           url: Constants.Service.LIST_MOVIES,
                           headers: headers,
                           parameters: parameters,
        success: { (response) in
            success(Movie.buildCollection(fromJSONArray: response.arrayValue))
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
}
