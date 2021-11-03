//
//  TestingViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import AsyncDisplayKit
import UIKit

class TestingViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Initializer (Required)

    let model = sampleMaintenance

    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.backgroundColor = .white

        let maintenanceCell = MaintenanceHistoryCell(model: sampleMaintenance)

        node.layoutSpecBlock = { _, _ in
            ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 50, left: 26, bottom: .infinity, right: 26),
                child: maintenanceCell
            )
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blue
    }
}

let sampleMaintenance: MaintenanceHistory =
    MaintenanceHistory(maintenanceTitle: "Check Accu Health",
                       maintenanceDate: "2 Aug 2021",
                       maintenanceOdometer: 10000,
                       workshopName: "Bengkel Gembira",
                       components: [ComponentList(componentID: 1,
                                                  componentListName: "Accu",
                                                  componentListPrice: 1000000)],
                       otherComponents: [OtherComponents(otherComponentName: "Kabel",
                                                         otherComponentPrice: "100000")],
                       maintenanceHistoryImage: "Gambar struck",
                       totalCost: 1100000)

