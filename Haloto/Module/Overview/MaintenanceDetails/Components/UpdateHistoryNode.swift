//
//  UpdateHistoryNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class UpdateHistoryNode: ASDisplayNode {
    let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimension(unit: .points, value: 76)
        node.backgroundColor = UIColor(hexString: "#FFFFFF")
        return node
    }()

    var updateHistoryButton: SmallButtonNode

    override init() {
        updateHistoryButton = SmallButtonNode(title: "Update History", buttonState: .Yellow, function: { print("Button Update History Pressed") })
        updateHistoryButton.style.width = ASDimensionMake(358)
        updateHistoryButton.style.height = ASDimensionMake(44)

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: .infinity, right: 16), child: updateHistoryButton)

        return ASOverlayLayoutSpec(child: backgroundNode, overlay: inset)
    }
}
