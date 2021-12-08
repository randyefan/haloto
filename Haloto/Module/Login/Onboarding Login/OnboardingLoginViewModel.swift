//
//  OnboardingLoginViewModel.swift
//  Haloto
//
//  Created by Javier Fransiscus on 07/12/21.
//

import Foundation
import RxCocoa
import RxSwift

internal class OnboardingLoginViewModel {

    internal struct Input {
        internal let tapAddVehicle: Driver<Void>
    }

    internal struct Output {
        internal let vehicleDidTapped: Driver<Void>
    }

    internal func transform(input: Input) -> Output {

        return Output(vehicleDidTapped: input.tapAddVehicle)
    }
}
