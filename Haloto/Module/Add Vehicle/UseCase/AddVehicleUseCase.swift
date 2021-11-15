//
//  AddVehicleUseCase.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 15/11/21.
//

import RxSwift
import RxCocoa
import Moya
import Foundation

internal struct AddVehicleUseCase {
    internal var listOfManufacture: () -> Observable<Result<VehicleManufacturerListResponse, NetworkError>>
    internal var listOfVehicleFromManufacturer: (_ manufacturer: String) -> Observable<Result<VehicleListResponse, NetworkError>>
    internal var addVehicle: (_ vehicleId: Int, _ currentOdometer: Int, _ licensePlat: String) -> Observable<Result<GeneralResponse, NetworkError>>
    
    internal static let provider = NetworkProvider<VehicleTarget>()
    
    internal init( listOfManufacture: @escaping () -> Observable<Result<VehicleManufacturerListResponse, NetworkError>>,
                   listOfVehicleFromManufacturer: @escaping (_ manufacturer: String) -> Observable<Result<VehicleListResponse, NetworkError>>,
                   addVehicle: @escaping (_ vehicleId: Int, _ currentOdometer: Int, _ licensePlat: String) -> Observable<Result<GeneralResponse, NetworkError>>)
    {
        self.listOfManufacture = listOfManufacture
        self.listOfVehicleFromManufacturer = listOfVehicleFromManufacturer
        self.addVehicle = addVehicle
    }
}

private func _listOfManufacture() -> Observable<Result<VehicleManufacturerListResponse, NetworkError>> {
    AddVehicleUseCase
        .provider
        .request(.listOfManufacture)
        .mapWithNetworkError(VehicleManufacturerListResponse.self)
}

private func _listOfVehicleFromManufacturer(_ manufacturer: String) -> Observable<Result<VehicleListResponse, NetworkError>> {
    AddVehicleUseCase
        .provider
        .request(.listOfVehicleFromManufacturer(manufacture: manufacturer))
        .mapWithNetworkError(VehicleListResponse.self)
}

private func _addVehicle(_ vehicleId: Int, _ currentOdometer: Int, _ licensePlat: String) -> Observable<Result<GeneralResponse, NetworkError>> {
    AddVehicleUseCase
        .provider
        .request(.addPersonalVehicle(vehicleId: vehicleId, currentOdometer: currentOdometer, licensePlate: licensePlat))
        .mapWithNetworkError(GeneralResponse.self)
}

extension AddVehicleUseCase {
    internal static var live = AddVehicleUseCase(
        listOfManufacture: _listOfManufacture,
        listOfVehicleFromManufacturer: _listOfVehicleFromManufacturer,
        addVehicle: _addVehicle)
}
