//
//  Constants.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

struct Constants {
    struct Keys {
        static let TOKEN: String = "token"
        static let WAS_FIRST_OPEN: String = "wasFirstOpen"
    }
    struct Localizable {
        static let APP_NAME = NSLocalizedString("Movie App", comment: "")
        
        static let DEFAULT_ERROR_MESSAGE: String = NSLocalizedString("There was a problem, please try later", comment: "")
        static let EMAIL = NSLocalizedString("Email", comment: "")
        static let EMAIL_NOT_VALID = NSLocalizedString("Email field is not valid", comment: "")
        static let LOGIN = NSLocalizedString("Login", comment: "")
        static let MOVIES = NSLocalizedString("Movies", comment: "")
        static let MOVIE_DETAIL = NSLocalizedString("Movie detail", comment: "")
        static let NO = NSLocalizedString("No", comment: "")
        static let OK = NSLocalizedString("Ok", comment: "")
        static let PASSWORD = NSLocalizedString("Password", comment: "")
        static let PASSWORD_NOT_VALID = NSLocalizedString("Password field is not valid", comment: "")
        static let SIG_IN = NSLocalizedString("Sign in", comment: "")
        static let SIGN_OUT_QUESTION: String = NSLocalizedString("Do you want to sign out?", comment: "")
        static let SOME_FIELDS_EMPTY = NSLocalizedString("Some fields empty", comment: "")
        static let YES = NSLocalizedString("Yes", comment: "")
    }
    struct Service {
        #if DEBUG
        private static let BASE_URL: String = "http://api-movies.pappstest.com/api/v1"
        #else
        private static let BASE_URL: String = ""
        #endif
        
        static let SIGN_IN = "\(BASE_URL)/auth/login"
        static let LIST_MOVIES = "\(BASE_URL)/movies"
    }
}
