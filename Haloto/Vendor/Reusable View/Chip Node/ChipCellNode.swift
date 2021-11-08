//
//  ChipCellNode.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit

internal final class ChipCellNode: ASCellNode {
    private let chipNode: ChipNode

    init(_ text: String, color: UIColor = .secondaryBlueApp) {
        chipNode = ChipNode(text, color: color)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: chipNode)
    }
}
