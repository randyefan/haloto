//
//  UserSignIn.swift
//  Haloto
//
//  Created by darindra.khadifa on 14/11/21.
//

import Foundation

public struct SignInResponse: Codable {
    public let status: Int
    public let message: String
}

public struct OTPResponse: Codable {
    public let status: Int
    public let message: String
    public let response: Token
}

public struct Token: Codable {
    public let token: String

    enum CodingKeys: String, CodingKey {
        case token = "access_token"
    }
}
