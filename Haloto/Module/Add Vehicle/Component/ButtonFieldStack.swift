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
    var isFilled: Bool
    
    private var firstButtonText: String = ""
    private var secondButtonText: String = ""

    private lazy var titleLabel: ASTextNode2 = {
        let node = ASTextNode2()

        return node
    }()

    private var firstButton: SmallButtonNode?
    private var secondButton: SmallButtonNode?

    init(title: String, firstButtonText: String, secondButtonText: String) {
        self.firstButtonText = firstButtonText
        self.secondButtonText = secondButtonText
        self.isFilled = false
        super.init()
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold, color: .black)
        automaticallyManagesSubnodes = true

        firstButton = SmallButtonNode(title: firstButtonText, buttonState: .BlueOutlined, function: {
            self.setFirstButtonActive()
        })
        firstButton?.style.width = ASDimensionMake("50%")
        secondButton = SmallButtonNode(title: secondButtonText, buttonState: .BlueOutlined, function: {
            self.setSecondButtonActive()
        })
        secondButton?.style.width = ASDimensionMake("50%")
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let buttonStack = ASStackLayoutSpec(direction: .horizontal, spacing: 4, justifyContent: .center, alignItems: .center, children: [firstButton!, secondButton!])
        buttonStack.style.width = ASDimensionMake("40%")

        let selectStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .spaceBetween, alignItems: .center, children: [titleLabel, buttonStack])
        selectStack.style.width = ASDimensionMake("100%")
        return selectStack
    }
}

extension ButtonFieldStack {
    func setFirstButtonActive() {
        firstButton?.setSelected(node: firstButton!)
        secondButton?.setUnselected(node: secondButton!)
    }

    func setSecondButtonActive() {
        firstButton?.setUnselected(node: firstButton!)
        secondButton?.setSelected(node: secondButton!)
    }
}
