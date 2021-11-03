//
//  UpcomingMaintenanceCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import AsyncDisplayKit
import UIKit

class UpcomingMaintenanceCell: ASCellNode {
    private let countUpcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let upcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 84, height: 78)
        node.backgroundColor = UIColor.backgroundUpcomingMaintenanceCell
        return node
    }()

    let upcomingMaintenanceDescription: UpcomingMaintenanceDescription

    init(model: UpcomingMaintenance) {
        countUpcomingMaintenanceNode.attributedText = .font("\(model.components.count)", size: 45, fontWeight: .bold, color: UIColor.white, alignment: .right, isTitle: false)

        upcomingMaintenanceNode.attributedText = .font("Components", size: 9, fontWeight: .regular, color: UIColor.white, alignment: .right, isTitle: false)

        upcomingMaintenanceDescription = UpcomingMaintenanceDescription(model: model)
        upcomingMaintenanceDescription.style.width = ASDimension(unit: .fraction, value: 1)
        upcomingMaintenanceDescription.style.flexShrink = 1

        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        setShadow()
    }

    func setShadow() {
        clipsToBounds = false
        cornerRadius = 8
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: -5, justifyContent: .center, alignItems: .center, children: [countUpcomingMaintenanceNode, upcomingMaintenanceNode])

        let backgroundInset = ASOverlayLayoutSpec(child: backgroundNode, overlay: stack)

        return ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [backgroundInset, upcomingMaintenanceDescription])
    }
}
