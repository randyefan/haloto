//
//  AppSettings.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 10/11/21.
//

import Foundation

enum AppSettings {
    static private let displayNameKey = "DisplayName"
    static private let chatIdKey = "chatChannelId"
    
    static var displayName: String? {
        get {
            return UserDefaults.standard.string(forKey: displayNameKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: displayNameKey)
        }
    }
    
    static var chatId: String? {
        get {
            return UserDefaults.standard.string(forKey: chatIdKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: chatIdKey)
        }
    }
}

