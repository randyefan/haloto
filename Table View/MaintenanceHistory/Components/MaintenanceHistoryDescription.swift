//
//  MaintenanceHistoryDescription.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit
import Foundation

class MaintenanceHistoryDescription: ASCellNode {
    private let maintenanceHistoryTitle: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let timeBadgeNode: ASImageNode?
    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let locationBadgeNode: ASImageNode?
    private let workshopNameNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(model: MaintenanceHistory) {
        maintenanceHistoryTitle.attributedText = .font(model.maintenanceTitle!,
                                                       size: 13,
                                                       fontWeight: .medium,
                                                       color: UIColor.black,
                                                       alignment: .left,
                                                       isTitle: true)

        timeBadgeNode = ASImageNode()
        timeBadgeNode?.image = UIImage(named: "timeBadge")
        dateNode.attributedText = .font(model.maintenanceDate!,
                                        size: 12,
                                        fontWeight: .regular,
                                        color: UIColor.black,
                                        alignment: .left,
                                        isTitle: false)

        locationBadgeNode = ASImageNode()
        locationBadgeNode?.image = UIImage(named: "locationBadge")
        workshopNameNode.attributedText = .font(model.workshopName!,
                                                size: 12,
                                                fontWeight: .regular,
                                                color: UIColor.black,
                                                alignment: .left,
                                                isTitle: false)

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let timeAndDateStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [timeBadgeNode, dateNode].compactMap { $0 })

        let locationAndWorkshopStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [locationBadgeNode, workshopNameNode].compactMap { $0 })

        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 17, justifyContent: .start, alignItems: .start, children: [timeAndDateStack, locationAndWorkshopStack].compactMap { $0 })

        return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [maintenanceHistoryTitle, stack])
    }
}
