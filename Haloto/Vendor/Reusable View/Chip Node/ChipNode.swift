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
        style.height = ASDimensionMake(22)
        backgroundColor = color
        textNode.attributedText = .font(text.uppercased(), size: 11, fontWeight: .medium)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: textNode)
    }
}
