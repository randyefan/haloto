//
//  CarVehicle+CoreDataProperties.swift
//  
//
//  Created by Dheo Gildas Varian on 07/12/21.
//
//

import Foundation
import CoreData


extension CarVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarVehicle> {
        return NSFetchRequest<CarVehicle>(entityName: "CarVehicle")
    }

    @NSManaged public var cc: String?
    @NSManaged public var currentOdometer: Int64
    @NSManaged public var fuelType: String?
    @NSManaged public var id: String?
    @NSManaged public var licensePlate: String?
    @NSManaged public var manufacture: String?
    @NSManaged public var manufactureYear: Int64
    @NSManaged public var model: String?
    @NSManaged public var transmission: String?
    @NSManaged public var maintenanceHistory: NSSet?

}

// MARK: Generated accessors for maintenanceHistory
extension CarVehicle {

    @objc(addMaintenanceHistoryObject:)
    @NSManaged public func addToMaintenanceHistory(_ value: CarMaintenanceHistory)

    @objc(removeMaintenanceHistoryObject:)
    @NSManaged public func removeFromMaintenanceHistory(_ value: CarMaintenanceHistory)

    @objc(addMaintenanceHistory:)
    @NSManaged public func addToMaintenanceHistory(_ values: NSSet)

    @objc(removeMaintenanceHistory:)
    @NSManaged public func removeFromMaintenanceHistory(_ values: NSSet)

}
