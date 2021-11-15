//
//  ReplacedTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 11/11/21.
//

import AsyncDisplayKit

class ReplacedTableNode: ASDisplayNode {
    let titleTable: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Replaced", size: 18, fontWeight: .bold, isTitle: true)
        return node
    }()

    let replacedTable: ASTableNode = {
        let node = ASTableNode()
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        // replacedTableNode.style.height = ASDimensionMake(50 * CGFloat(model.count + 1))
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTable, replacedTable]
        )

        return ASWrapperLayoutSpec(layoutElement: stack)
    }
}
