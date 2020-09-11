//
//  LoginRepository.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

final class LoginRepository {
    private let keychainHandler: StoreHandlerProtocol
    
    init(keychainHandler: StoreHandlerProtocol) {
        self.keychainHandler = keychainHandler
    }
    
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
        success: { [weak self] (response) in
            guard let self = self else { return }
            let token = response["token"].stringValue
            self.keychainHandler.save(value: token, to: Constants.Keys.TOKEN)
            success()
        }) { (error) in
            failure(error.localizedDescription)
        }
    }
}
