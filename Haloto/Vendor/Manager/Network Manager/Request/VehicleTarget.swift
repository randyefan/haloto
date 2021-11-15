//
//  VehicleTarget.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 15/11/21.
//

import Foundation
import Moya

internal enum VehicleTarget {
    case listOfManufacture
    case listOfVehicleFromManufacturer(manufacture: String)
    case addPersonalVehicle(vehicleId: Int, currentOdometer: Int, licensePlate: String)
}

extension VehicleTarget: TargetType {
    internal var baseURL: URL {
        return URL(string: "\(Constants.BASE_URL)/vehicle")!
    }
    
    internal var path: String {
        switch self {
        case .listOfManufacture:
            return "/manufacturer"
        case let .listOfVehicleFromManufacturer(manufacture):
            return "/\(manufacture)/model"
        case .addPersonalVehicle:
            return "/personal-vehicle"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .listOfManufacture, .listOfVehicleFromManufacturer:
            return .get
        case .addPersonalVehicle:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .listOfManufacture, .listOfVehicleFromManufacturer:
            return .requestPlain
        case .addPersonalVehicle:
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .listOfManufacture, .listOfVehicleFromManufacturer, .addPersonalVehicle:
            return [
//                "Authorization" : "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicGhvbmUiOiI2MjgxMjEzMDIyMDExIiwiaWF0IjoxNjM2OTQ0ODg3fQ.91jaRrAiuWtJRukSe3VOQBE1yG2TVvo_D7KrMY99VOg",
                "Authorization" : "Bearer \(DefaultManager.shared.getString(forKey: .AccessTokenKey) ?? "")",
                "Content-Type" : "application/json"
            ]
        }
    }
    
    internal var params: [String: Any] {
        switch self {
        case let .addPersonalVehicle(vehicleId, currentOdometer, licensePlate):
            return [
                "vehicle_ID" : vehicleId,
                "current_odometer" : currentOdometer,
                "license_plate" : licensePlate
            ]
        default:
            return [:]
        }
    }
}
