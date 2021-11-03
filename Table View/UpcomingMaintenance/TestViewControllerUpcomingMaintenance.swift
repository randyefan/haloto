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
        
        let upcoming = UpcomingMaintenanceCell()

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

