//
//  StoreHandlerProtocol.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

protocol StoreHandlerProtocol {
    func array<T>(of type: T.Type, from key: String) -> [T]?
    func bool(from key: String) -> Bool
    func data(from key: String) -> Data?
    func integer(from key: String) -> Int
    func string(from key: String) -> String?
    func custom<T: Codable>(of class: T.Type, from key: String) -> T?
    func remove(from key: String) -> Bool
    func save(value: Any?, to key: String)
    func save<T: Codable>(_ value: T, to key: String) -> Bool
}
extension StoreHandlerProtocol {
    func array(from key: String) -> [String]? {
        array(of: String.self, from: key)
    }
}
