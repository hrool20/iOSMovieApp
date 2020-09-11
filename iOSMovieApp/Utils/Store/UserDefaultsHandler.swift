//
//  UserDefaultsHandler.swift
//  iOSMovieApp
//
//  Copyright © 2020 Hrool. All rights reserved.
//

import Foundation

final class UserDefaultsHandler: StoreHandlerProtocol {
    private let userDefaults: UserDefaults
    
    init() {
        userDefaults = .standard
    }
    
    init(suiteName: String) {
        guard let userDefaults = UserDefaults(suiteName: suiteName) else {
            fatalError("Suite name is not correct")
        }
        self.userDefaults = userDefaults
    }
    
    func array<T>(of type: T.Type, from key: String) -> [T]? {
        guard let array = userDefaults.array(forKey: key) as? [T] else {
            return nil
        }
        return array
    }
    
    func bool(from key: String) -> Bool {
        return userDefaults.bool(forKey: key)
    }
    
    func data(from key: String) -> Data? {
        return userDefaults.data(forKey: key)
    }
    
    func integer(from key: String) -> Int {
        return userDefaults.integer(forKey: key)
    }
    
    func string(from key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func custom<T>(of class: T.Type, from key: String) -> T? where T : Decodable, T : Encodable {
        guard let data = userDefaults.data(forKey: key),
            let custom = try? JSONDecoder().decode(T.self, from: data) as T else {
                return nil
        }
        return custom
    }
    
    func remove(from key: String) -> Bool {
        userDefaults.removeObject(forKey: key)
        return true
    }
    
    func save(value: Any?, to key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func save<T>(_ value: T, to key: String) -> Bool where T : Decodable, T : Encodable {
        guard let data = try? JSONEncoder().encode(value) else { return false }
        userDefaults.set(data, forKey: key)
        return true
    }
    
    
}
