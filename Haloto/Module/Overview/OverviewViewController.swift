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

        super.init(node: ASScrollNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.layoutSpecBlock = { _, _ in
            // guard let self = self else { return ASLayoutSpec() }
            let inset = 
            ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [vehicleSection, upcomingMaintenanceSection])
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
