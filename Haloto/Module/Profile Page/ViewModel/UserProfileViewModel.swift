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
    public let personalVehicle: PublishSubject<[Vehicle]> = PublishSubject()
    
    private let dispose = DisposeBag()
    
    public func requestDataProfile(){
        //TODO: requestDataHere Profile
        //self.profile.onNext("")
    }
    
    public func requestPersonalVehicleData(){
        //TODO: request Personal Vehicle
        //self.personalVehicle.onNext("")
    }
    
    public func saveNewProfileData(newProfileData: Profile){
        //TODO: saveProfileData
    }
}
