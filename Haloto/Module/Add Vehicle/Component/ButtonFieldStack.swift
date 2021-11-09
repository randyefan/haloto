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
        let node = SmallButtonNode(title: "firstButtonText", buttonState: .BlueOutlined, function: .none)
        return node
    }()
    
    private lazy var secondButton: SmallButtonNode = {
        let node = SmallButtonNode(title: "secondButtonText", buttonState: .BlueOutlined, function: .none)
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
        let buttonStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [firstButton, secondButton])
        let selectStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .spaceBetween, alignItems: .center, children: [titleLabel, buttonStack])
        return selectStack
    }
}
