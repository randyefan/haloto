//
//  UpcomingMaintenanceSection.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit
import os

class UpcomingMaintenanceSection: ASDisplayNode {

    let model = sampleUpcoming
    private let upcomingMaintenanceNode: [UpcomingMaintenanceCell]

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(model: [UpcomingMaintenance]) {
        upcomingMaintenanceNode = (0 ..< 3).map { index in
            let tempNode = UpcomingMaintenanceCell(model: model[index])
            return tempNode
        }
        
        titleNode.attributedText = .font(
            "Upcoming Maintenance",
            size: 18,
            fontWeight: .bold,
            color: UIColor.black
        )
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack =  ASStackLayoutSpec(
            direction: .vertical,
            spacing: 14,
            justifyContent: .start,
            alignItems: .stretch,
            children: upcomingMaintenanceNode
        )
        
        let final = ASStackLayoutSpec(direction: .vertical, spacing: 11, justifyContent: .start, alignItems: .stretch, children: [titleNode, stack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16), child: final)
    }
}


