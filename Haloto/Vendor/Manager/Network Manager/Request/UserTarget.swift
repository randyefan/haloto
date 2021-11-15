//
//  UserSignUpTarget.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/14/21.
//

import Moya
import RxSwift

internal enum UserTarget {
    case signUp(name: String, email: String, phone: String)
    case signIn(phone: String)
    case validateOTP(otp: String, phone: String)
}

extension UserTarget: TargetType {
    internal var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/user")!
    }

    internal var path: String {
        switch self {
        case .signUp:
            return "/sign-up"
        case .signIn:
            return "/sign-in"
        case .validateOTP:
            return "/validate-otp"
        }
    }

    internal var method: Moya.Method {
        switch self {
        case .signUp, .signIn, .validateOTP:
            return .post
        }
    }

    internal var task: Task {
        switch self {
        case .signUp, .signIn, .validateOTP:
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }

    internal var headers: [String: String]? {
        return nil
    }

    internal var params: [String: Any] {
        switch self {
        case let .signUp(name, email, phone):
                return [
                "fullname": name,
                "email": email,
                "phone": phone,
            ]
        case let .signIn(phone):
            return ["phone": phone]
        case let .validateOTP(otp, phone):
            return [
                "otp": otp,
                "phone": phone
            ]
        }
    }
}
