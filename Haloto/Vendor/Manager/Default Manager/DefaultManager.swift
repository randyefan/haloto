//
//  DefaultManager.swift
//  Haloto
//
//  Created by darindra.khadifa on 14/11/21.
//

import Foundation

enum DefaultKey: String {
    case AccessTokenKey
    case AccessRefreshTokenKey
    case UserDataKey
    case Language
    case LoginStatus
    case isNotFirstLogin
}

public struct DefaultManager {
    static let shared = DefaultManager()
    private init() { }

    func set(value: Any?, forKey key: DefaultKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }

     func getString(forKey key: DefaultKey) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }

     func removeString(forKey key: DefaultKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }

     func getDate(forKey key: DefaultKey) -> Date? {
        return UserDefaults.standard.object(forKey: key.rawValue) as? Date
    }

     func getArray(forKey key: DefaultKey) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }

     func getInt(forKey key: DefaultKey) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }

     func getBool(forKey key: DefaultKey) -> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }

     func setStruct<T: Codable>(_ value: T?, forKey key: DefaultKey) {
        let data = try? JSONEncoder().encode(value)
        set(value: data, forKey: key)
    }

     func setStructArray<T: Codable>(_ value: [T], forKey key: DefaultKey) {
        let data = value.map { try? JSONEncoder().encode($0) }
        set(value: data, forKey: key)
    }

     func structData<T>(_ type: T.Type, forKey key: DefaultKey) -> T? where T: Decodable {
        guard let encodedData = UserDefaults.standard.data(forKey: key.rawValue) else {
            return nil
        }

        return try! JSONDecoder().decode(type, from: encodedData)
    }

     func structArrayData<T>(_ type: T.Type, forKey key: DefaultKey) -> [T] where T: Decodable {
        guard let encodedData = UserDefaults.standard.array(forKey: key.rawValue) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}
