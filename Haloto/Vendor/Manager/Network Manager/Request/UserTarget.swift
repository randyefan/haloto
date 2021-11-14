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
}

extension UserTarget: TargetType {
    internal var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/user")!
    }

    internal var path: String {
        switch self {
        case .signUp:
            return "/sign-up"
        }
    }

    internal var method: Moya.Method {
        switch self{
        case .signUp:
            return .post
        }
    }

    internal var task: Task {
        switch self {
        case .signUp:
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
        }
    }
}
