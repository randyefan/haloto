//
//  CoreDataManager.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 07/12/21.
//

import Foundation
import CoreData
import UIKit

struct CoreDataManager{
    static var shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Haloto")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    func setVehicle(carVehicle: Vehicle){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let vehicleEntity = NSEntityDescription.entity(forEntityName: "CarVehicle", in: context) else { return }
        
        let vehicle = NSManagedObject(entity: vehicleEntity, insertInto: context)
        vehicle.setValue(carVehicle.odometer, forKey: "currentOdometer")
        vehicle.setValue(carVehicle.name, forKey: "model")
        vehicle.setValue("\(carVehicle.capacity ?? 0 )", forKey: "cc")
        vehicle.setValue(carVehicle.fuelType, forKey: "fuelType")
        vehicle.setValue(carVehicle.licensePlate, forKey: "licensePlate")
        vehicle.setValue(carVehicle.manufacture, forKey: "manufacture")
        vehicle.setValue(Int(carVehicle.manufacturedYear ?? ""), forKey: "manufactureYear")
        vehicle.setValue(carVehicle.transmissionType, forKey: "transmission")
        vehicle.setValue("\(countVehicle() + 1 )", forKey: "id")
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func countVehicle() -> Int {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarVehicle")
        do {
            let vehicle = try context.fetch(fetchRequest)
            return vehicle.count == 0 ? 0 : vehicle.count
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return 0
        }
    }
    
    func getPersonalVehicleList() -> [CarVehicle]? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarVehicle")
        do {
            let vehicle = try context.fetch(fetchRequest)
            return vehicle as? [CarVehicle]
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return nil
        }
    }
    
    func generateUpcamingMaintenance(vehicleId: String) -> [UpcomingMaintenance]? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarVehicle")
        fetchRequest.predicate = NSPredicate(format: "id == %@", vehicleId)
        do {
            let vehicle = try context.fetch(fetchRequest)
            
            if let newVehicle = vehicle as? [CarVehicle], vehicle.count != 0 {
                let odometer = newVehicle.first?.currentOdometer ?? 0
                return listOfUpcomingMaintenanceDummy.filter({ $0.nextServiceOdometer! > odometer })
            }
        } catch {
            print("fail")
            return nil
        }
        
        return nil
    }
    
    func getMaintenanceHistory(vehicle: CarVehicle) -> [CarMaintenanceHistory]? {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarMaintenanceHistory")
        fetchRequest.predicate = NSPredicate(format: "vehicle == %@", vehicle)
        do {
            let vehicle = try context.fetch(fetchRequest)
            return vehicle as? [CarMaintenanceHistory]
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveMaintenanceHistory(maintenanceHistory: MaintenanceHistory, image: UIImage? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let maintenanceEntity = NSEntityDescription.entity(forEntityName: "CarMaintenanceHistory", in: context) else { return }
        let maintenance = NSManagedObject(entity: maintenanceEntity, insertInto: context)
        maintenance.setValue(maintenanceHistory.serviced, forKey: "serviced")
        maintenance.setValue(maintenanceHistory.workshopName, forKey: "location")
        maintenance.setValue(maintenanceHistory.maintenanceDate, forKey: "date")
        maintenance.setValue(maintenanceHistory.maintenanceTitle, forKey: "title")
        maintenance.setValue("\(countMaintenanceHistory() + 1 )", forKey: "id")
        if let image = image {
            maintenance.setValue(image.pngData() ?? Data(), forKey: "image")
        }
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
    
    func countMaintenanceHistory() -> Int {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarMaintenanceHistory")
        do {
            let maintenance = try context.fetch(fetchRequest)
            return maintenance.count == 0 ? 0 : maintenance.count
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return 0
        }
    }
    
    func updateMaintenanceHistory(maintenanceHistory: MaintenanceHistory, maintenanceId: String, image: UIImage? = nil) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarMaintenanceHistory")
        fetchRequest.predicate = NSPredicate(format: "id == %@", maintenanceId)
        do {
            let maintenance = try context.fetch(fetchRequest)
            if maintenance.count != 0 {
                let object = maintenance[0]
                object.setValue(maintenanceHistory.maintenanceTitle, forKey: "title")
                object.setValue(maintenanceHistory.maintenanceDate, forKey: "date")
                object.setValue(maintenanceHistory.serviced, forKey: "serviced")
                object.setValue(maintenanceHistory.workshopName, forKey: "location")
                if let image = image {
                    object.setValue(image.pngData() ?? Data(), forKey: "image")
                }
                do {
                    try context.save()
                } catch {
                    fatalError()
                }
            }
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return
        }
    }
}
