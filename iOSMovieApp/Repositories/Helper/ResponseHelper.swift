//
//  ResponseHelper.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RequestType: String {
    case url = "url"
    case json = "json"
}

struct ResponseHelper {
    static func POST(with type: RequestType, url: String, headers: [String: String]? = nil, parameters: [String: Any], success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        let encoding: ParameterEncoding
        switch type {
        case .url:
            encoding = URLEncoding.default
        case .json:
            encoding = JSONEncoding.default
        }
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: encoding,
                   headers: HTTPHeaders(headers ?? [:]))
        .responseJSON { (response) in
            validate(response: response, success: success, failure: failure)
        }
    }
    
    static func GET(with type: RequestType, url: String, headers: [String: String]? = nil, parameters: [String: Any]?, success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        let encoding: ParameterEncoding
        switch type {
        case .url:
            encoding = URLEncoding.default
        case .json:
            encoding = JSONEncoding.default
        }
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   encoding: encoding,
                   headers: HTTPHeaders(headers ?? [:]))
        .responseJSON { (response) in
            validate(response: response, success: success, failure: failure)
        }
    }
    
    private static func validate(response: AFDataResponse<Any>, success: @escaping(JSON) -> Void, failure: @escaping(Error) -> Void) {
        switch response.result {
        case .failure(let error):
            print("AFError: \(error.localizedDescription)")
            failure(error)
        case .success(let value):
            let jsonObject = JSON(value)
            print("Response: \(response.response?.statusCode ?? 0) - \(jsonObject)")
            
            guard let _ = jsonObject["status"].int else {
                let statusCode = response.response?.statusCode ?? 500
                let errorMessage = jsonObject["message"].string ?? Constants.Localizable.DEFAULT_ERROR_MESSAGE
                failure(NSError(domain: "MA", code: statusCode, userInfo: [
                    NSLocalizedDescriptionKey: errorMessage
                ]))
                return
            }
            success(jsonObject["data"])
        }
    }
}
