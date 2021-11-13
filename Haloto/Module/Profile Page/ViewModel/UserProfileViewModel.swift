//
//  UserProfileViewModel.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/13/21.
//

import RxSwift
import Foundation
import RxCocoa

class UserProfileViewModel {
    
    //MARK: - Obersevers
    public let networkError: PublishSubject<NetworkError> = PublishSubject()
    public let profile: PublishSubject<Profile> = PublishSubject()
    
    private let dispose = DisposeBag()
    
    public func requestDataProfile(){
        self.isLoading.onNext(true)
        //TODO: requestDataHere
        self.isLoading.onNext(false)
    }
}
