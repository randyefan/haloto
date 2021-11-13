//
//  ModelDummy.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 11/11/21.
//

import Foundation

// Vehicle Dummy
let vehicle1 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2017", capacity: 1300, transmissionType: "Automatic", licensePlate: "B 123 CD", isDefault: true)
let vehicle2 = Vehicle(name: "Innova", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2017", capacity: 1500, transmissionType: "Automatic", licensePlate: "B 234 CK", isDefault: false)
let vehicle3 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2017", capacity: 1300, transmissionType: "Manual", licensePlate: "B 3812 PK", isDefault: false)
let vehicle4 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2017", capacity: 1500, transmissionType: "Manual", licensePlate: "B 8932 UH", isDefault: false)
let vehicle5 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2016", capacity: 1300, transmissionType: "Automatic", licensePlate: "B 1283 GH", isDefault: false)
let vehicle6 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2016", capacity: 1500, transmissionType: "Automatic", licensePlate: "B 2712 VG", isDefault: false)
let vehicle7 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2016", capacity: 1300, transmissionType: "Manual", licensePlate: "B 3181 YG", isDefault: false)
let vehicle8 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2016", capacity: 1500, transmissionType: "Manual", licensePlate: "B 1203 ABD", isDefault: false)
let vehicle9 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2015", capacity: 1300, transmissionType: "Automatic", licensePlate: "B 3012 AS", isDefault: false)
let vehicle10 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2015", capacity: 1500, transmissionType: "Automatic", licensePlate: "B 261 TA", isDefault: false)
let vehicle11 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2015", capacity: 1300, transmissionType: "Manual", licensePlate: "B 2171 PHN", isDefault: false)
let vehicle12 = Vehicle(name: "Avanza", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2015", capacity: 1500, transmissionType: "Manual", licensePlate: "B 1299 AD", isDefault: false)
let vehicle13 = Vehicle(name: "Agya", fuelType: "Petrol", manufacture: "Toyota", manufacturedYear: "2017", capacity: 1000, transmissionType: "Automatic", licensePlate: "B 1293 JL", isDefault: false)

// Component Dummy
let component1 = Component(name: "Kabel Aki", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component2 = Component(name: "Dinamo Starter Mobil", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component3 = Component(name: "Dinamo Starter Busi", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component4 = Component(name: "Fan Belt / V-Belt", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component5 = Component(name: "Klakson", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component6 = Component(name: "Alternator", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component7 = Component(name: "Evaporator", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component8 = Component(name: "Dryer", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component9 = Component(name: "Expansion Valve", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component10 = Component(name: "Filter Kabin/AC", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component11 = Component(name: "Kompresor", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component12 = Component(name: "Kondensor", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component13 = Component(name: "Kampas Rem Belakang", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component14 = Component(name: "Kampas Rem Depan", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component15 = Component(name: "Disc Brake Depan", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component16 = Component(name: "ABS Speed Sensor", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component17 = Component(name: "Booster Rem", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component18 = Component(name: "Kabel Rem Tangan", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")
let component19 = Component(name: "Oli Transmisi", componentImage: "", lastReplacementDate: "", lifetimeOdometer: 20000, lifetimeDate:"")

// Upcoming Maintenance
let upcomingMaintenance1 = UpcomingMaintenance(components: [component1, component2, component3, component4], nextServiceOdometer: 20000, nextServiceDate: "1 Jan 2022"
)
let upcomingMaintenance2 = UpcomingMaintenance(components: [component5, component6, component7], nextServiceOdometer: 30000, nextServiceDate: "15 Juni 2022"
)
let upcomingMaintenance3 = UpcomingMaintenance(components: [component7, component8, component9, component10], nextServiceOdometer: 40000, nextServiceDate: "11 Jan 2023"
)

// List of Vehicle Dummy
let listOfVehicleDummy = [vehicle1, vehicle13, vehicle2]
let listOfUpcomingMaintenanceDummy = [upcomingMaintenance1, upcomingMaintenance2, upcomingMaintenance3]


// Speciality
let speciality1 = Speciality(specialityID: 0, specialityName: "Mesin")
let speciality2 = Speciality(specialityID: 1, specialityName: "Umum")
let speciality3 = Speciality(specialityID: 2, specialityName: "Interior")
let speciality4 = Speciality(specialityID: 3, specialityName: "Ketok Magic")
let speciality5 = Speciality(specialityID: 4, specialityName: "Variasi")
let speciality6 = Speciality(specialityID: 5, specialityName: "Velg & Ban")
let speciality7 = Speciality(specialityID: 6, specialityName: "Cat")
let speciality8 = Speciality(specialityID: 7, specialityName: "Audio")
let speciality9 = Speciality(specialityID: 8, specialityName: "Jok")
let speciality10 = Speciality(specialityID: 9, specialityName: "Lampu")
let speciality11 = Speciality(specialityID: 10, specialityName: "Toyota")
let speciality12 = Speciality(specialityID: 11, specialityName: "Honda")
let speciality13 = Speciality(specialityID: 12, specialityName: "Mitsubishi")
let speciality14 = Speciality(specialityID: 13, specialityName: "Ford")
let speciality15 = Speciality(specialityID: 14, specialityName: "Kia")
let speciality16 = Speciality(specialityID: 15, specialityName: "Mazda")

// List Of Speciality
let listOfSpeciality1 = [speciality1, speciality2]
let listOfSpeciality2 = [speciality2, speciality7]
let listOfSpecialty3 = [speciality8, speciality3, speciality9]
let listOfSpecialty4 = [speciality7, speciality4]
let listOfSpeciality5 = [speciality6, speciality7]


// Free Pricing
let freePrice = Payment(fee: 0, tax: 0)

// Bengkel
let bengkel1 = Bengkel(id: 0,
                       namaBengkel: "Abadi",
                       rating: 4.5,
                       ratingCount: 700,
                       speciality: listOfSpeciality1,
                       payment: freePrice)
let bengkel2 = Bengkel(id: 1,
                       namaBengkel: "Selamet Abadi",
                       rating: 3,
                       ratingCount: 100,
                       speciality: listOfSpeciality2,
                       payment: freePrice)
let bengkel3 = Bengkel(id: 2,
                       namaBengkel: "Jaya Motor",
                       rating: 4.9,
                       ratingCount: 635,
                       speciality: listOfSpecialty3,
                       payment: freePrice)
let bengkel4 = Bengkel(id: 3,
                       namaBengkel: "Raja Service",
                       rating: 3.1,
                       ratingCount: 105,
                       speciality: listOfSpecialty4,
                       payment: freePrice)
let bengkel5 = Bengkel(id: 4,
                       namaBengkel: "Karunia Auto",
                       rating: 4.8,
                       ratingCount: 10,
                       speciality: listOfSpeciality5,
                       payment: freePrice)
let bengkel6 = Bengkel(id: 5,
                       namaBengkel: "Resmi Toyota (Auto 2000)",
                       rating: 4.7,
                       ratingCount: 900,
                       speciality: [speciality11],
                       payment: freePrice)
let bengkel7 = Bengkel(id: 6,
                       namaBengkel: "Resmi Honda (Union)",
                       rating: 4.9,
                       ratingCount: 1243,
                       speciality: [speciality12],
                       payment: freePrice)

let bengkel8 = Bengkel(id: 7,
                       namaBengkel: "Resmi Kia Mobil Indonesia",
                       rating: 4.8,
                       ratingCount: 986,
                       speciality: [speciality15],
                       payment: freePrice)
let bengkel9 = Bengkel(id: 8,
                       namaBengkel: "Resmi Mitsubishi",
                       rating: 4.9,
                       ratingCount: 1243,
                       speciality: [speciality13],
                       payment: freePrice)
let bengkel10 = Bengkel(id: 9,
                       namaBengkel: "Resmi Honda (Union)",
                       rating: 4.9,
                       ratingCount: 1243,
                       speciality: [speciality12],
                       payment: freePrice)

let listOfBengkelDummy = [bengkel1, bengkel2, bengkel3, bengkel4, bengkel5, bengkel6, bengkel7, bengkel8, bengkel9, bengkel10]

// ComponentList
let componentList1 = ComponentList(componentID: 0,
                                   componentListName: "Oli Mesin",
                                   componentListPrice: 325000)
let componentList2 = ComponentList(componentID: 1,
                                   componentListName: "Filter Oli",
                                   componentListPrice: 100000)
let componentList3 = ComponentList(componentID: 2,
                                   componentListName: "Filter Udara",
                                   componentListPrice: 150000)
let componentList4 = ComponentList(componentID: 3,
                                   componentListName: "Minyak Rem",
                                   componentListPrice: 50000)
let componentList5 = ComponentList(componentID: 4,
                                   componentListName: "Filter Bahan Bakar",
                                   componentListPrice: 70000)
let componentList6 = ComponentList(componentID: 5,
                                   componentListName: "Coolant Mesin",
                                   componentListPrice: 80000)
let componentList7 = ComponentList(componentID: 6,
                                   componentListName: "Busi",
                                   componentListPrice: 240000)
let componentList8 = ComponentList(componentID: 7,
                                   componentListName: "Accu",
                                   componentListPrice: 780000)

// Maintenance History
let maintenanceHistory1 = MaintenanceHistory(maintenanceTitle: "Service 20.000 Km",
                                             maintenanceDate: "1 Jan 2020",
                                             maintenanceOdometer: 21245,
                                             workshopName: "Bengkel Toyota Auto 2000",
                                             serviced: [],
                                             replaced: [componentList1, componentList2],
                                             otherComponents: [],
                                             maintenanceHistoryImage: nil,
                                             totalCost: 250000)
let maintenanceHistory2 = MaintenanceHistory(maintenanceTitle: "Service 30.000 Km",
                                             maintenanceDate: "16 Juni 2020",
                                             maintenanceOdometer: 31357,
                                             workshopName: "Tunas Toyota Jakarta",
                                             serviced: [],
                                             replaced: [componentList1, componentList6, componentList5],
                                             otherComponents: [],
                                             maintenanceHistoryImage: nil,
                                             totalCost: 475000)
let maintenanceHistory3 = MaintenanceHistory(maintenanceTitle: "Service 40.000 Km",
                                             maintenanceDate: "4 Desember 2020",
                                             maintenanceOdometer: 49757,
                                             workshopName: "Bengkel Toyota Auto 2000",
                                             serviced: [],
                                             replaced: [componentList1, componentList6, componentList7],
                                             otherComponents: [],
                                             maintenanceHistoryImage: nil,
                                             totalCost: 200000)

let listOfMaintenanceHistory = [maintenanceHistory1, maintenanceHistory2, maintenanceHistory3]
