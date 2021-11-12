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
    private var OTP: Driver<String>
    private let phoneNumber: Driver<String>
    private let useCase: LoginUseCase

    internal init(OTP: Driver<String>, phoneNumber: Driver<String>, useCase: LoginUseCase = LoginUseCase.live) {
        self.OTP = OTP
        self.phoneNumber = phoneNumber
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
        internal let OTPMatched: Driver<Bool>
        internal let phoneNumber: Driver<String>
        internal let OTPResent: Driver<String>
    }

    internal func transform(input: Input) -> Output {
        var newOTP = OTPGenerator.shared.getOTP()

        var checkOTP = input.submit.withLatestFrom(input.textFieldTriger)
            .flatMapLatest { [OTP] otpInput -> Driver<Bool> in
            return Driver.combineLatest(OTP, Driver.just(otpInput)).map { $0 == $1 }
        }

        let resendOTP = input.resendOtpDidTap.withLatestFrom(phoneNumber).flatMap { [useCase] phoneNumber -> Driver<WhatsappResponse> in
            newOTP = OTPGenerator.shared.getOTP()
            return useCase
                .sendOTP(phoneNumber.replacingCharacters(in: ...phoneNumber.startIndex, with: "62"), newOTP.message)
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }

        OTP = resendOTP.flatMapLatest { _ -> Driver<String> in
            Driver.just(newOTP.code)
        }

        checkOTP = input.submit.withLatestFrom(input.textFieldTriger)
            .flatMapLatest { [OTP] otpInput -> Driver<Bool> in
            return Driver.combineLatest(OTP, Driver.just(otpInput)).map { $0 == $1 }
        }

        return Output(
            signUpDidTap: input.tapSignUp,
            OTPMatched: checkOTP,
            phoneNumber: phoneNumber,
            OTPResent: OTP
        )
    }
}
