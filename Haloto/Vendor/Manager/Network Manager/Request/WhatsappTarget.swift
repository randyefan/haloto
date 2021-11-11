//
//  WhatsappTarget.swift
//  Haloto
//
//  Created by darindra.khadifa on 11/11/21.
//

import Moya
import RxSwift

internal enum WhatsappTarget {
    case sendOTP(phoneNumber: String, message: String)
}

extension WhatsappTarget: TargetType {
    internal var baseURL: URL {
        return URL(string: "https://api.kirimwa.id/v1")!
    }

    internal var path: String {
        switch self {
        case .sendOTP:
            return "/messages"
        }
    }

    internal var method: Moya.Method {
        return .post
    }

    internal var task: Task {
        switch self {
        case .sendOTP:
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    internal var headers: [String: String]? {
        return [
            "Authorization": "Bearer M}D4jhn2SW@wQBVCcOFAXUskG/|D@uCSqLdXyiY2}PfeJk=1-darindra",
            "Content-Type": "application/json",
        ]
    }

    internal var params: [String: Any] {
        switch self {
        case let .sendOTP(phoneNumber, message):
            return [
                "phone_number": phoneNumber,
                "message": message,
                "device_id": "haloto",
                "message_type": "text"
            ]
        }
    }

}
