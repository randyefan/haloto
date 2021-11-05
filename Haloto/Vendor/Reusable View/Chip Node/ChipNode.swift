//
//  ChipNode.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit

internal final class ChipNode: ASDisplayNode {

    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(_ text: String, color: UIColor = .secondaryBlueApp) {
        super.init()
        automaticallyManagesSubnodes = true

        backgroundColor = color
        textNode.attributedText = .font(text.uppercased(), size: 11, fontWeight: .medium, alignment: .center)
    }

    override func layout() {
        super.layout()
        style.height = ASDimensionMake(22)
        cornerRadius = 22 / 2
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 4, left: 12, bottom: 4, right: 12),
            child: textNode
        )
    }
}
