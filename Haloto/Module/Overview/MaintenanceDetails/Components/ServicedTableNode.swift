//
//  ServicedTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class ServicedTableNode: ASDisplayNode {
    let titleTable: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Serviced", size: 18, fontWeight: .bold, isTitle: true)
        return node
    }()

    let servicedTable: ASTableNode = {
        let node = ASTableNode()
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
//        servicedTable.style.height = ASDimensionMake(50 * CGFloat(model.count + 1))
        servicedTable.style.height = ASDimensionMake(100)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTable, servicedTable]
        )

        return ASWrapperLayoutSpec(layoutElement: stack)
    }
}
