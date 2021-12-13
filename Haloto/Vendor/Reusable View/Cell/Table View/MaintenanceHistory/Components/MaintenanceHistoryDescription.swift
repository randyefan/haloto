//
//  MaintenanceHistoryDescription.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit
import Foundation

class MaintenanceHistoryDescription: ASDisplayNode {
    private let maintenanceHistoryTitle: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 2
        return node
    }()

    private let timeBadgeNode: ASImageNode = {
        let node = ASImageNode()
        return node
    }()

    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let locationBadgeNode: ASImageNode = {
        let node = ASImageNode()
        return node
    }()

    private let workshopNameNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 2
        node.style.flexShrink = 1
        return node
    }()

    init(model: CarMaintenanceHistory) {
        maintenanceHistoryTitle.attributedText = .font(
            "\(model.title ?? "")",
            size: 13,
            fontWeight: .medium
        )

        timeBadgeNode.image = UIImage(named: "timeBadge")
        dateNode.attributedText = .font(
            "\(model.date ?? Date())",
            size: 12,
            fontWeight: .regular,
            color: UIColor.lightGray
        )

        locationBadgeNode.image = UIImage(named: "locationBadge")
        workshopNameNode.attributedText = .font("\(model.location ?? "")",
                                                size: 12,
                                                fontWeight: .regular,
                                                color: UIColor.black,
                                                alignment: .left,
                                                isTitle: false)
        workshopNameNode.attributedText = .font(
            "\(model.location ?? "")",
            size: 12,
            fontWeight: .regular,
            color: UIColor.lightGray
        )

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let timeAndDateStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [timeBadgeNode, dateNode].compactMap { $0 })

        let locationAndWorkshopStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [locationBadgeNode, workshopNameNode].compactMap { $0 })
        
        locationAndWorkshopStack.style.flexShrink = 1
        
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 17, justifyContent: .start, alignItems: .start, children: [timeAndDateStack, locationAndWorkshopStack].compactMap { $0 })

        return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [maintenanceHistoryTitle, stack])
    }
}
