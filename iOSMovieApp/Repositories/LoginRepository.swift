//
//  LoginRepository.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

class LoginRepository {
    static let shared = LoginRepository()
    
    func signIn(email: String, password: String, success: @escaping() -> Void, failure: @escaping(String) -> Void) {
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        let headers: [String: String] = [
            "Accept": "application/json"
        ]
        
        ResponseHelper.POST(with: .json,
                            url: Constants.Service.SIGN_IN,
                            headers: headers,
                            parameters: parameters,
        success: { (response) in
            let token = response["token"].stringValue
            UserDefaults.standard.set(token, forKey: Constants.Keys.TOKEN)
            success()
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
}
