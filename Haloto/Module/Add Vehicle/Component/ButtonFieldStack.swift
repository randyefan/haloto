//
//  ButtonFieldStack.swift
//  Haloto
//
//  Created by Javier Fransiscus on 10/11/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

class ButtonFieldStack: ASDisplayNode {
    private var firstButtonText: String = ""
    private var secondButtonText: String = ""

    private lazy var titleLabel: ASTextNode2 = {
        let node = ASTextNode2()

        return node
    }()

    private lazy var firstButton: SmallButtonNode = {
        let node = SmallButtonNode(title: firstButtonText, buttonState: .BlueOutlined, function: .none)
        node.style.width = ASDimensionMake("50%")
        return node
    }()
    
    private lazy var secondButton: SmallButtonNode = {
        let node = SmallButtonNode(title: secondButtonText, buttonState: .BlueOutlined, function: .none)
        node.style.width = ASDimensionMake("50%")
        return node
    }()
    
    init(title: String, firstButtonText: String, secondButtonText: String) {
        self.firstButtonText = firstButtonText
        self.secondButtonText = secondButtonText
        super.init()
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold, color: .black)

        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let buttonStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .center, alignItems: .center, children: [firstButton, secondButton])
        buttonStack.style.width = ASDimensionMake("40%")
        let selectStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .spaceBetween, alignItems: .center, children: [titleLabel, buttonStack])
        selectStack.style.width = ASDimensionMake("100%")
        return selectStack
    }
}
