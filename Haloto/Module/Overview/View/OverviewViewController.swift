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
    
    // MARK: - Initializer (Required)
    override init() {
        let vehicle = CoreDataManager.shared.getPersonalVehicleList()
        vehicleNode.modelVehicle = vehicle
        
        let modelUpcoming = CoreDataManager.shared.generateUpcamingMaintenance(vehicleId: vehicle?[0].id ?? "0")
        upcomingMaintenanceNode = UpcomingMaintenanceSection(model: modelUpcoming ?? [])
        
        if let model = vehicle {
            let maintenanceHistory = CoreDataManager.shared.getMaintenanceHistory(vehicle: model[0])
            maintenanceHistoryNode = MaintenanceHistorySection(model: maintenanceHistory ?? [])
        }
        
        super.init(node: ASScrollNode())
        maintenanceHistoryNode?.action = {
            
        }
        
        upcomingMaintenanceNode?.action = { index in
            if let modelUpcoming = modelUpcoming {
                let vc = UpcomingMaintenancePanModal(maintenance: modelUpcoming[index])
                let bottomSheet = BottomSheetViewController(wrapping: vc)
                self.navigationController?.present(bottomSheet, animated: true, completion: nil)
            }
        }
        
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
