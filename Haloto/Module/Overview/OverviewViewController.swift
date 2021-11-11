//
//  OverviewViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit
import UIKit

class OverviewViewController: ASDKViewController<ASScrollNode> {
    // MARK: - Variable Node
    let vehicleNode: VehicleSection = {
        let node = VehicleSection()
        return node
    }()
    
    var upcomingMaintenanceNode: UpcomingMaintenanceSection?
    var maintenanceHistoryNode: MaintenanceHistorySection?
    
    // MARK: - Variable Model
    var modelUpcoming: [UpcomingMaintenance]?
    var modelMaintenanceHistory: [MaintenanceHistory]?
    var modelVehicle: [Vehicle]?
    
    // MARK: - Initializer (Required)
    override init() {
        modelUpcoming = listOfUpcomingMaintenanceDummy
        modelMaintenanceHistory = arrayOfListMaintenaceHistoryDummy[0]
        modelVehicle = listOfVehicleDummy
        
        vehicleNode.modelVehicle = modelVehicle
        upcomingMaintenanceNode = UpcomingMaintenanceSection(model: modelUpcoming ?? [])
        maintenanceHistoryNode = MaintenanceHistorySection(model: modelMaintenanceHistory ?? [])
        
        
        super.init(node: ASScrollNode())
        vehicleNode.delegate = self
        node.automaticallyManagesSubnodes = true
        node.automaticallyManagesContentSize = true
        node.layoutSpecBlock = { _, _ in
            
            let stack =  ASStackLayoutSpec(
                direction: .vertical,
                spacing: 10,
                justifyContent: .start,
                alignItems: .stretch,
                children: [self.vehicleNode, self.upcomingMaintenanceNode, self.maintenanceHistoryNode].compactMap({ $0 }))
            
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 0, bottom: 70, right: 0), child: stack)
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
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension OverviewViewController: VehicleSectionDelegate {
    func changeVehicle(index: Int) {
        modelMaintenanceHistory = arrayOfListMaintenaceHistory[index]
        maintenanceHistoryNode = MaintenanceHistorySection(model: modelMaintenanceHistory ?? [])
        node.setNeedsLayout()
    }
}
