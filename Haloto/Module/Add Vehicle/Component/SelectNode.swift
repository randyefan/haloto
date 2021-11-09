//
//  SelectFieldStack.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import Foundation

class SelectNode: ASDisplayNode {
    init(placeholder: String) {
        super.init()
        placeholderLabel.attributedText = .font(placeholder, size: 12, fontWeight: .regular, color: .gray, alignment: .left)
        automaticallyManagesSubnodes = true
    }

    private lazy var rightChevronButton: ASImageNode = {
        let imageView = ASImageNode()
        imageView.image = UIImage(named: "chevron-forward")
        return imageView
    }()

    private lazy var placeholderLabel: ASTextNode2 = {
        let label = ASTextNode2()
        return label
    }()

    override func layout() {
        borderColor = UIColor.greyApp.cgColor
        shadowColor = UIColor.blackApp.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 0
        shadowRadius = 4
        borderWidth = 1
        cornerRadius = 5
        super.layout()
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let selectNode = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [placeholderLabel, rightChevronButton])
        selectNode.style.width = ASDimensionMake("100%")
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8), child: selectNode)
    }
}
