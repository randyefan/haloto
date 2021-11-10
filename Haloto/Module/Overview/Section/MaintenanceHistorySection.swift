//
//  MaintenanceHistorySection.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 08/11/21.
//

import AsyncDisplayKit

class MaintenanceHistorySection: ASDisplayNode {
    let model = sampleMaintenanHistory

    private let maintenanHistoryNode: [MaintenanceHistoryCell]

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private var buttonAdd: SmallButtonNode?

    init(model: [MaintenanceHistory]) {
        maintenanHistoryNode = (0 ..< model.count).map { index in
            let tempNode = MaintenanceHistoryCell(model: model[index])
            return tempNode
        }

        titleNode.attributedText = .font(
            "Maintenance History",
            size: 18,
            fontWeight: .bold,
            color: UIColor.black
        )

        buttonAdd = SmallButtonNode(title: "+ Add New", buttonState: .BlueOutlined, function: { print("Button Add Tapped") })
        buttonAdd?.style.width = ASDimensionMake(90)

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 14,
            justifyContent: .start,
            alignItems: .stretch,
            children: maintenanHistoryNode
        )

        let titleAndButtonStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [titleNode, buttonAdd].compactMap { $0 }
        )

        let finalStack = ASStackLayoutSpec(direction: .vertical, spacing: 11, justifyContent: .start, alignItems: .stretch, children: [titleAndButtonStack, stack])

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16), child: finalStack)
    }
}
