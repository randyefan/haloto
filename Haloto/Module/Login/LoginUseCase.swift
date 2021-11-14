//
//  OTPUseCase.swift
//  Haloto
//
//  Created by darindra.khadifa on 11/11/21.
//

import RxSwift
import RxCocoa
import Moya

internal struct LoginUseCase {
    internal var login: (_ phone: String) -> Observable<Result<SignInResponse, NetworkError>>
    internal var validateOTP: (_ otp: String, _ phone: String) -> Observable<Result<OTPResponse, NetworkError>>
    internal static let provider = NetworkProvider<UserTarget>()

    internal init(
        login: @escaping (_ phoneNumber: String) -> Observable<Result<SignInResponse, NetworkError>>,
        validateOTP: @escaping(_ otp: String, _ phone: String) -> Observable<Result<OTPResponse, NetworkError>>
    ) {
        self.login = login
        self.validateOTP = validateOTP
    }
}

private func _login(_ phone: String) -> Observable<Result<SignInResponse, NetworkError>> {
    LoginUseCase
        .provider
        .request(.signIn(phone: phone))
        .mapWithNetworkError(SignInResponse.self)
}

private func _validateOTP(_ otp: String, _ phone: String) -> Observable<Result<OTPResponse, NetworkError>> {
    LoginUseCase
        .provider
        .request(.validateOTP(otp: otp, phone: phone))
        .mapWithNetworkError(OTPResponse.self)
}

extension LoginUseCase {
    internal static var live = LoginUseCase(login: _login, validateOTP: _validateOTP)
}
