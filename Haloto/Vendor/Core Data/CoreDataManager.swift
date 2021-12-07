//
//  CoreDataManager.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 07/12/21.
//

import Foundation
import CoreData

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
    
    func setVehicle(carVehicle: CarVehicle){
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let vehicleEntity = NSEntityDescription.entity(forEntityName: "CarVehicle", in: context) else { return }
        
        let vehicle = NSManagedObject(entity: vehicleEntity, insertInto: context)
        vehicle.setValue(carVehicle.currentOdometer, forKey: "currentOdometer")
        vehicle.setValue(carVehicle.model, forKey: "model")
        vehicle.setValue(carVehicle.cc, forKey: "cc")
        vehicle.setValue(carVehicle.fuelType, forKey: "fuelType")
        vehicle.setValue(carVehicle.model, forKey: "model")
        vehicle.setValue(carVehicle.licensePlate, forKey: "licensePlate")
        vehicle.setValue(carVehicle.manufacture, forKey: "manufacture")
        vehicle.setValue(carVehicle.manufactureYear, forKey: "manufactureYear")
        vehicle.setValue(carVehicle.transmission, forKey: "transmission")
        vehicle.setValue(countVehicle() + 1, forKey: "id")
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
    
    func generateUpcamingMaintenance(vehicleId: Int) -> [UpcomingMaintenance]? {
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
    
    func saveMaintenanceHistory(maintenanceHistory: CarMaintenanceHistory) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        guard let vehicleEntity = NSEntityDescription.entity(forEntityName: "CarMaintenanceHistory", in: context) else { return }
        
    }
    
    func updateMaintenanceHistory(maintenanceHistory: MaintenanceHistory, maintenanceId: Int) {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CarMaintenanceHistory")
        fetchRequest.predicate = NSPredicate(format: "id == %@", maintenanceId)
        do {
            let maintenance = try context.fetch(fetchRequest) as! [NSManagedObject]
            if let maintenance = maintenance, maintenance.count != 0 {
                var object = maintenance[0]
                object.setValue(maintenanceHistory.maintenanceTitle, "title")
            }
        } catch {
            print("could not fetch \(error.localizedDescription)")
            return
        }
    }
    
}
