//
//  UserSignUp.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/14/21.
//

import Foundation

struct SignUpReponse: Codable {
    var message: String
    var response: SignUpDetail
}

struct SignUpDetail: Codable {
    var createdAt: String
    var updatedAt: String
    var id: Int
    var fullname: String
    var email: String
    var phone: String
}

