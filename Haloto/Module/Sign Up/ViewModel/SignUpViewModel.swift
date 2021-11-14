//
//  SignUpViewModel.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/14/21.
//

import Foundation
import RxCocoa
import RxSwift

class SignUpViewModel {
    // MARK: - Observers

    let useCase: SignUpUseCase
    
    public let name = BehaviorSubject<String>(value: "")
    public let email = BehaviorSubject<String>(value: "")
    public let phone = BehaviorSubject<String>(value: "")
    public let isFilled: Observable<Bool>
    public let networkError: PublishSubject<NetworkError> = PublishSubject()
    public let isLoading: PublishSubject<Bool> = PublishSubject()
    
    public var successRegister: Observable<SignUpReponse>?

    private let dispose = DisposeBag()

    init(useCase: SignUpUseCase = SignUpUseCase.live) {
        self.useCase = useCase
        
        isFilled = Observable.combineLatest(
            name.asObservable(), email.asObservable(), phone.asObservable()
        ) { name, email, phone in
            return name.count > 0 && email.count > 0 && phone.count > 0
        }
    }

    public func signUpNewProfile() {
        isLoading.onNext(true)
        
        
        

        // if success
        print("User Successfuly Registered")
        isLoading.onNext(false)
    }
}
