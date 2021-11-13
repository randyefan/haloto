//
//  OtherTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import AsyncDisplayKit

class OtherTableNode: ASDisplayNode {
    let titleTable: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Others", size: 18, fontWeight: .bold, isTitle: true)
        return node
    }()

    let otherTableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
//        otherTableNode.style.height = ASDimensionMake(50 * CGFloat(model.count + 1))
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTable, otherTableNode]
        )

        return ASWrapperLayoutSpec(layoutElement: stack)
    }
}
