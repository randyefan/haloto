//
//  OverviewUseCase.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 15/11/21.
//

import RxSwift
import RxCocoa
import Moya
import Foundation

internal struct OverviewUseCase {
    internal var listOfPersonalVehicle: () -> Observable<Result<PersonalVehicleListResponse, NetworkError>>
    
    internal static let providerVehicle = NetworkProvider<VehicleTarget>()
    
    internal init(listOfPersonalVehicle: @escaping () -> Observable<Result<PersonalVehicleListResponse, NetworkError>>) {
        self.listOfPersonalVehicle = listOfPersonalVehicle
    }
}

private func _listOfPersonalVehicle() -> Observable<Result<PersonalVehicleListResponse, NetworkError>> {
    OverviewUseCase
        .providerVehicle
        .request(.listOfPersonalVehicle)
        .mapWithNetworkError(PersonalVehicleListResponse.self)
}

extension OverviewUseCase {
    internal static var live = OverviewUseCase(
        listOfPersonalVehicle: _listOfPersonalVehicle
    )
}
