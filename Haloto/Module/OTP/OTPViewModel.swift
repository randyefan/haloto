//
//  OTPViewModel.swift
//  Haloto
//
//  Created by Javier Fransiscus on 04/11/21.
//

import Foundation
import RxCocoa
import RxSwift

internal class OTPViewModel {
    private let phone: Driver<String>
    private let useCase: LoginUseCase

    internal init(phone: Driver<String>, useCase: LoginUseCase = LoginUseCase.live) {
        self.phone = phone
        self.useCase = useCase
    }

    internal struct Input {
        internal let textFieldTriger: Driver<String>
        internal let submit: Driver<Void>
        internal let resendOtpDidTap: Driver<Void>
        internal let tapSignUp: Driver<Void>
    }

    internal struct Output {
        internal let signUpDidTap: Driver<Void>
        internal let OTPMatched: Driver<String>
        internal let phone: Driver<String>
        internal let OTPResent: Driver<SignInResponse>
    }

    internal func transform(input: Input) -> Output {
        let validateParam = Driver.combineLatest(input.textFieldTriger, phone)
        let checkOTP = input.submit.withLatestFrom(validateParam).flatMapLatest { [useCase]otp, phone -> Driver<String> in
            useCase
                .validateOTP(otp, phone)
                .compactMap(\.success)
                .compactMap { $0.response.token }
                .asDriverOnErrorJustComplete()
        }

        let resendOTP = input.resendOtpDidTap.withLatestFrom(phone).flatMap { [useCase] phone -> Driver<SignInResponse> in
            useCase
                .login(phone)
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }

        return Output(
            signUpDidTap: input.tapSignUp,
            OTPMatched: checkOTP,
            phone: phone,
            OTPResent: resendOTP
        )
    }
}
