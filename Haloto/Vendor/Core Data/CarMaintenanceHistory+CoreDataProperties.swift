//
//  CarMaintenanceHistory+CoreDataProperties.swift
//  
//
//  Created by Dheo Gildas Varian on 07/12/21.
//
//

import Foundation
import CoreData


extension CarMaintenanceHistory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarMaintenanceHistory> {
        return NSFetchRequest<CarMaintenanceHistory>(entityName: "CarMaintenanceHistory")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var location: String?
    @NSManaged public var serviced: [String]?
    @NSManaged public var title: String?
    @NSManaged public var vehicle: CarVehicle?

}
