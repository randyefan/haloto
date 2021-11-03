//
//  TestViewControllerUpcomingMaintenance.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import UIKit
import AsyncDisplayKit

class TestViewControllerUpcomingMaintenance: ASDKViewController<ASDisplayNode> {
    
    // MARK: - Initializer (Required)
    
    
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white
        
        let upcoming = UpcomingMaintenanceCell(model: sampleUpcomingMaintenance )

        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 50, left: 26, bottom: .infinity, right: 26),
                child: upcoming
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blue
    }
}

let sampleUpcomingMaintenance : UpcomingMaintenance =
    UpcomingMaintenance(components: [Component(name: "Accu",
                                               lastReplacementOdometer: 20000,
                                               lastReplacementDate: "1 Jan 2020",
                                               lifetimeOdometer: 0,
                                               lifetimeDate: "1 Jan 2019")],
                        nextServiceOdometer: 40000,
                        nextServiceDate: "1 Jan 2021")


