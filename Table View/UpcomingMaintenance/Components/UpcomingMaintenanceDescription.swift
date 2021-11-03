//
//  UpcomingMaintenanceDescription.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import AsyncDisplayKit

class UpcomingMaintenanceDescription: ASCellNode {
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let subTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 2
        return node
    }()

    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.style.alignSelf = .end
        return node
    }()

    init(model: UpcomingMaintenance) {
        titleNode.attributedText = .font(
            "\(model.nextServiceOdometer) KM Service",
            size: 14,
            fontWeight: .medium
        )

        subTitleNode.attributedText = .font(
            "Check \(model.components.first?.name ?? "") and \(model.components.count - 1) other",
            size: 12,
            color: UIColor.lightGray
        )

        dateNode.attributedText = .font(
            model.nextServiceDate,
            size: 11,
            fontWeight: .medium
        )
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .start,
            children: [titleNode, subTitleNode]
        )

        let finalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 10,
            justifyContent: .start,
            alignItems: .start,
            children: [stack, dateNode]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), child: finalStack)
    }
}
