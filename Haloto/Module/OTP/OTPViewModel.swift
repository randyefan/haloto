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
    private let OTP: Driver<String>
    private let phoneNumber: Driver<String>

    internal init(OTP: Driver<String>, phoneNumber: Driver<String>) {
        self.OTP = OTP
        self.phoneNumber = phoneNumber
    }

    internal struct Input {
        internal let textFieldTriger: Driver<String>
        internal let submit: Driver<Void>
        internal let resendOtpDidTap: Driver<Void>
        internal let tapSignUp: Driver<Void>
    }

    internal struct Output {
        internal let signUpDidTap: Driver<Void>
        internal let OTPMatched: Driver<Bool>
        internal let phoneNumber: Driver<String>
    }

    internal func transform(input: Input) -> Output {
        let checkOTP = input.submit.withLatestFrom(input.textFieldTriger)
            .flatMapLatest { [OTP] otpInput -> Driver<Bool> in
            return Driver.combineLatest(OTP, Driver.just(otpInput)).map { $0 == $1 }
        }

        return Output(
            signUpDidTap: input.tapSignUp,
            OTPMatched: checkOTP,
            phoneNumber: phoneNumber
        )
    }
}
