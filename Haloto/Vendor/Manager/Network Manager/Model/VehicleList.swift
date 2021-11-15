//
//  VehicleList.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 15/11/21.
//

import Foundation

// MARK: - List of Manufacturer

struct VehicleManufacturerListResponse: Codable {
    let status: Int?
    let message: String?
    let response: [VehicleManufacturerResponse]?
}

struct VehicleManufacturerResponse: Codable {
    let manufacturer: String?
}

// MARK: - List of vehicle from a manufacturer

struct VehicleListResponse: Codable {
    let status: Int?
    let message: String?
    let response: [VehicleResponse]?
}

struct VehicleResponse: Codable {
    let id: Int?
    let name: String?
    let fuelType: String?
    let manufacturer: String?
    let vehicleImage: String?
    let manufacturerYear: Int?
    let cc: Int?
    let transmission: VehicleTransmissionResponse?
    
    enum CodingKeys: String, CodingKey {
        case id, name, manufacturer, cc, transmission
        case fuelType = "fuel_type"
        case manufacturerYear = "manufacture_year"
        case vehicleImage = "vehicle_image"
    }
}

struct VehicleTransmissionResponse: Codable {
    let id: Int?
    let type: String?
}

// MARK: - Personal Vehicle

struct PersonalVehicleListResponse: Codable {
    let status: Int?
    let message: String?
    let response: [PersonalVehicleResponse]?
}

struct PersonalVehicleResponse: Codable {
    let id: Int?
    let userId: Int?
    let vehicleId: Int?
    let currentOdometer: Int?
    let licensePlate: String?
    let isDefault: Int?
    let type: VehicleResponse?
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case userId = "user_ID"
        case vehicleId = "vehicle_ID"
        case currentOdometer = "current_odometer"
        case licensePlate = "license_plate"
        case isDefault = "is_default"
    }
}
