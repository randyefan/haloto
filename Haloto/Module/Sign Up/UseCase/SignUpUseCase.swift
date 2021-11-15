//
//  SignUpUseCase.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/14/21.
//

import RxSwift
import RxCocoa
import Moya
import Foundation

internal struct SignUpUseCase {
    internal var signUp: (_ name: String, _ email: String, _ phone: String) -> Observable<Result<SignInResponse, NetworkError>>
    internal static let provider = NetworkProvider<UserTarget>()
    
    internal init(signUp: @escaping (_ name: String, _ email: String, _ phone: String) -> Observable<Result<SignInResponse, NetworkError>>) {
        self.signUp = signUp
    }
}

extension SignUpUseCase {
    internal static var live = SignUpUseCase { name, email, phone in
        SignUpUseCase
            .provider
            .request(.signUp(name: name, email: email, phone: phone))
            .mapWithNetworkError(SignInResponse.self)
    }
}
