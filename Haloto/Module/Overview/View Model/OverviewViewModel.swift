//
//  OverviewViewModel.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import RxSwift
import UIKit
import RxCocoa

class OverviewViewModel {
    // MARK: - Use Case
    
    let useCase: OverviewUseCase
    
    // MARK: - Observer Variable
    
    // Personal vehicle needed
    let personalVehicleList = BehaviorRelay<[PersonalVehicleResponse]>(value: [])
    let vehicleList = BehaviorRelay<[Vehicle]>(value: [])
    
    // MARK: - Initializer
    
    init(useCase: OverviewUseCase = OverviewUseCase.live) {
        self.useCase = useCase
    }
    
    // MARK: - Bind (Input-Output-Transform) View Model
    
    internal struct Input {
        internal let viewDidLoad: Driver<Void>
    }
    
    internal struct Output {
        internal let listOfPersonalVehicle: Driver<PersonalVehicleListResponse>
    }
    
    internal func transform(input: Input) -> Output {
        let responseListOfPersonalVehicle = input.viewDidLoad.flatMapLatest { [useCase] _ -> Driver<PersonalVehicleListResponse> in
            return useCase
                .listOfPersonalVehicle()
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }
        
        return Output (
            listOfPersonalVehicle: responseListOfPersonalVehicle
        )
    }
    
    // MARK: - Transform response to model
    
    func modelManufacture(responseModel: [PersonalVehicleResponse]) {
        personalVehicleList.accept(responseModel)
        let vehicle = responseModel.map({
            Vehicle(name: $0.type?.name ?? "",
                    fuelType: $0.type?.fuelType ?? "",
                    manufacture: $0.type?.manufacturer ?? "",
                    manufacturedYear: "\($0.type?.manufacturerYear ?? 0)",
                    capacity: $0.type?.cc ?? 0,
                    transmissionType: $0.type?.transmission?.type ?? "",
                    licensePlate: $0.licensePlate ?? "",
                    odometer: $0.currentOdometer ?? 0,
                    isDefault: Bool(truncating: ($0.isDefault ?? 0) as NSNumber))
        })
        vehicleList.accept(vehicle)
    }
}
