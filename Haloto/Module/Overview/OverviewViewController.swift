//
//  OverviewViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit
import UIKit

class OverviewViewController: ASDKViewController<ASScrollNode> {
    // MARK: - Initializer (Required)

    override init() {
        let vehicleSection = VehicleSection()
        let upcomingMaintenanceSection = UpcomingMaintenanceSection(model: sampleUpcoming)
        let maintenanceHistorySection = MaintenanceHistorySection(model: sampleMaintenanHistory)

        super.init(node: ASScrollNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.layoutSpecBlock = { _, _ in

            ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [vehicleSection, upcomingMaintenanceSection, maintenanceHistorySection])
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white

        navigationController?.isNavigationBarHidden = true
    }
}

let sampleUpcoming: [UpcomingMaintenance] = [
    UpcomingMaintenance(components: [Component(name: "Accu",
                                               lastReplacementOdometer: 20000,
                                               lastReplacementDate: "1 Jan 2020",
                                               lifetimeOdometer: 0,
                                               lifetimeDate: "1 Jan 2019")],
                        nextServiceOdometer: 40000,
                        nextServiceDate: "1 Jan 2021"),
    
    UpcomingMaintenance(components: [Component(name: "Filter",
                                               lastReplacementOdometer: 20000,
                                               lastReplacementDate: "1 Jan 2020",
                                               lifetimeOdometer: 0,
                                               lifetimeDate: "1 Jan 2019")],
                        nextServiceOdometer: 20000,
                        nextServiceDate: "1 Jan 2021"),
    UpcomingMaintenance(components: [Component(name: "Oli",
                                               lastReplacementOdometer: 20000,
                                               lastReplacementDate: "1 Jan 2020",
                                               lifetimeOdometer: 0,
                                               lifetimeDate: "1 Jan 2019")],
                        nextServiceOdometer: 10000,
                        nextServiceDate: "1 Jan 2021"),
]

let sampleMaintenanHistory: [MaintenanceHistory] = [
    MaintenanceHistory(
        maintenanceTitle: "Check Accu Health",
        maintenanceDate: "2 Aug 2021",
        maintenanceOdometer: 20000,
        workshopName: "Bengkel Gembira asdasdasdasdasdasdas",
        components: [ComponentList(
            componentID: 1,
            componentListName: "Accu",
            componentListPrice: 1000000
        )],
        maintenanceHistoryImage: "maintenanceHistoryImage",
        totalCost: 1000000),
    
    MaintenanceHistory(
        maintenanceTitle: "Check Filter Health",
        maintenanceDate: "7 Jan 2021",
        maintenanceOdometer: 20000,
        workshopName: "Bengkel Gembira Banget",
        components: [ComponentList(
            componentID: 2,
            componentListName: "Filter",
            componentListPrice: 200000
        )],
        maintenanceHistoryImage: "maintenanceHistoryImage",
        totalCost: 200000),
    
    MaintenanceHistory(
        maintenanceTitle: "Check Oli Health",
        maintenanceDate: "2 Feb 2021",
        maintenanceOdometer: 20000,
        workshopName: "Bengkel Gembira Aja",
        components: [ComponentList(
            componentID: 3,
            componentListName: "Oli",
            componentListPrice: 300000
        )],
        maintenanceHistoryImage: "maintenanceHistoryImage",
        totalCost: 300000)
]

let sampleVehicle: [Vehicle] = [
    Vehicle(name: "Brio", fuelType: "Bensin", manufacture: "HONDA", manufacturedYear: "2020", capacity: 1500, transmissionType: "Matic", licensePlate: "B 1234 AX", isDefault: true),
    Vehicle(name: "Brio", fuelType: "Bensin", manufacture: "HONDA", manufacturedYear: "2020", capacity: 1500, transmissionType: "Matic", licensePlate: "B 1234 AX", isDefault: true),
    Vehicle(name: "Brio", fuelType: "Bensin", manufacture: "HONDA", manufacturedYear: "2020", capacity: 1500, transmissionType: "Matic", licensePlate: "B 1234 AX", isDefault: true)
]
