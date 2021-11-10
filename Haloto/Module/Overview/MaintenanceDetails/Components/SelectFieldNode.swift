//
//  SelectedNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class SelectFieldNode: ASDisplayNode {
    private var placeholderText: String = ""

    private lazy var titleLabel: ASTextNode2 = {
        let node = ASTextNode2()

        return node
    }()

    private lazy var selectNode: SelectNode = {
        let node = SelectNode(placeholder: placeholderText)

        return node
    }()

    init(title: String, placeholder: String) {
        placeholderText = placeholder
        super.init()
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold, color: .black)

        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let selectStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [titleLabel, selectNode])
        return selectStack
    }
}
