//
//  LoginViewModel.swift
//  Haloto
//
//  Created by Javier Fransiscus on 04/11/21.
//

import Foundation
import RxCocoa
import RxSwift

internal class LoginViewModel {
    internal let useCase: LoginUseCase

    internal struct Input {
        internal let textFieldTriger: Driver<String>
        internal let submit: Driver<Void>
        internal let tapSignUp: Driver<Void>
    }

    internal struct Output {
        internal let signUpDidTap: Driver<Void>
        internal let OTPSent: Driver<OTPViewModel>
    }

    internal init(useCase: LoginUseCase = LoginUseCase.live) {
        self.useCase = useCase
    }

    internal func transform(input: Input) -> Output {
        let response = input.submit.withLatestFrom(input.textFieldTriger)
            .flatMapLatest { [useCase] phone -> Driver<SignInResponse> in
            useCase
                .login(phone)
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }

        let OTPSent = response.flatMapLatest { _ -> Driver<OTPViewModel> in
            Driver.just(OTPViewModel(phone: input.textFieldTriger))
        }

        return Output(signUpDidTap: input.tapSignUp, OTPSent: OTPSent)
    }
}
