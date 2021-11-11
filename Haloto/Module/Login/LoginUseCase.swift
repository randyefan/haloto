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
    internal var sendOTP: (_ phoneNumber: String, _ message: String) -> Observable<Result<WhatsappResponse, NetworkError>>
    internal static let provider = NetworkProvider<WhatsappTarget>()

    internal init(sendOTP: @escaping (_ phoneNumber: String, _ message: String) -> Observable<Result<WhatsappResponse, NetworkError>>) {
        self.sendOTP = sendOTP
    }
}

extension LoginUseCase {
    internal static var live = LoginUseCase { phoneNumber, message in
        LoginUseCase
            .provider
            .request(.sendOTP(phoneNumber: phoneNumber, message: message))
            .mapWithNetworkError(WhatsappResponse.self)
    }
}
