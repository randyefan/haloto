//
//  AddVehicleViewModel.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 15/11/21.
//

import Foundation
import RxCocoa
import RxSwift

class AddVehicleViewModel {
    
    let useCase: AddVehicleUseCase
    
    let manufacturerObjectList = BehaviorRelay<[Manufacturer]?>(value: nil)
    let modelVehicleObjectList = BehaviorRelay<[Model]?>(value: nil)

    let vehicleSelected = PublishSubject<VehicleResponse>()
    let listOfVehicle = BehaviorRelay<[VehicleResponse]>(value: [])
    
    internal struct Input {
        internal let viewDidLoad: Driver<Void>
        internal let manufacturedFilled: Driver<String>
        internal let currentOdometer: Driver<String>
        internal let licensePlate: Driver<String>
        internal let addVehicleDidTap: Driver<Void>
    }
    
    internal struct Output {
        internal let listOfManufacture: Driver<VehicleManufacturerListResponse>
        internal let listOfVehicleByManufacture: Driver<VehicleListResponse>
        internal let addVehicle: Driver<GeneralResponse>
    }
    
    init(useCase: AddVehicleUseCase = AddVehicleUseCase.live) {
        self.useCase = useCase
    }
    
    func modelManufacture(responseModel: VehicleManufacturerListResponse) {
        guard let model = responseModel.response else { return }
        let manufacture = model.map { Manufacturer(name: $0.manufacturer?.uppercased() ) }
        manufacturerObjectList.accept(manufacture)
    }
    
    func modelVehicle(responseModel: VehicleListResponse) {
        guard let model = responseModel.response else { return }
        
        listOfVehicle.accept(model)
        
        let modelVehicle = model.map { Model(name: "\($0.name ?? "") \($0.cc ?? 0) CC \($0.fuelType ?? "") \($0.transmission?.type ?? "")".uppercased()) }
        modelVehicleObjectList.accept(modelVehicle)
    }
    
    internal func transform(input: Input) -> Output {
        let responseListOfManufacture = input.viewDidLoad.flatMapLatest { [useCase] _ -> Driver<VehicleManufacturerListResponse> in
            useCase
                .listOfManufacture()
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }
        
        let responseListOfVehicle = input.manufacturedFilled.flatMapLatest { [useCase] manufacturer -> Driver<VehicleListResponse> in
            useCase
                .listOfVehicleFromManufacturer(manufacturer)
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }
        
        let vehicleData = Driver.combineLatest(vehicleSelected.asDriverOnErrorJustComplete(), input.currentOdometer.asDriver(), input.licensePlate.asDriver())
        
        let responseAddVehicle = input.addVehicleDidTap.withLatestFrom(vehicleData).flatMapLatest { [useCase] (vehicle, odometer, licensePlat) -> Driver<GeneralResponse> in
            useCase
                .addVehicle(vehicle.id ?? 0, Int(odometer) ?? 0, licensePlat)
                .compactMap(\.success)
                .asDriverOnErrorJustComplete()
        }
        
        return Output(
            listOfManufacture: responseListOfManufacture,
            listOfVehicleByManufacture: responseListOfVehicle,
            addVehicle: responseAddVehicle
        )
    }
}
