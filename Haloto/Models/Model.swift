//
//  Model.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import Foundation

struct Vehicle: Codable {
    var name: String?
    var fuelType: String?
    var manufacture: String?
    var manufacturedYear: String?
    var capacity: Int?
    var transmissionType: String?
    var licensePlate: String?
    var odometer: Int?
    var isDefault: Bool?
}

struct UpcomingMaintenance: Codable {
    var components: [Component]?
    var nextServiceOdometer: Int?
    var nextServiceDate: String?
}

struct Component: Codable {
    var name: String?
    var componentImage: String?
    var lastReplacementOdometer: Int?
    var lastReplacementDate: String?
    var lifetimeOdometer: Int?
    var lifetimeDate: String?
}

struct MaintenanceHistory: Codable {
    var maintenanceTitle: String?
    var maintenanceDate: String?
    var maintenanceOdometer: Int?
    var workshopName: String?
    var serviced: [ComponentList]?
    var replaced: [ComponentList]?
    var otherComponents: [OtherComponents]?
    var maintenanceHistoryImage: String?
    var totalCost: Int?
}

struct ComponentList: Codable {
    var componentID: Int?
    var componentListName: String?
    var componentListPrice: Int?
}

struct OtherComponents: Codable {
    var otherComponentName: String?
    var otherComponentPrice: String?
}

struct Profile: Codable {
    var profilePicture: Data?
    var profileName: String?
    var profileEmail: String?
    var profilePhone: String?
    var authorizationToken: String?
}

struct ProfileWorkshop: Codable {
    var profilePicture: String?
    var profileName: String?
    var profileEmail: String?
    var profilePhone: String?
    var authorizationToken: String?
    var businessHours: String?
    var profileDescription: String?
    var profileRating: Int?
    var speciality: [Speciality]?
}

struct Speciality: Codable {
    var specialityID: Int?
    var specialityName: String?
}

struct Manufacturer: Codable {
    let name: String?
}

struct Model: Codable {
    let name: String?
}

struct Payment: Codable {
    let fee: Double?
    let tax: Double?
}

struct Bengkel: Codable {
    let id: Int?
    let namaBengkel: String?
    let rating: Double?
    let ratingCount: Int?
    let speciality: [Speciality]?
    let payment: Payment?
}
