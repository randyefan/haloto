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

    private var firstButton: SmallButtonNode?
    private var secondButton: SmallButtonNode?
    
    init(title: String, firstButtonText: String, secondButtonText: String) {
        self.firstButtonText = firstButtonText
        self.secondButtonText = secondButtonText
        super.init()
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold, color: .black)
        automaticallyManagesSubnodes = true
        
        firstButton = SmallButtonNode(title: firstButtonText, buttonState: .BlueOutlined, function: {
            self.firstButton?.setSelected(node: self.firstButton!)
            self.secondButton?.setUnselected(node: self.secondButton!)
        })
        firstButton?.style.width = ASDimensionMake("40%")
        secondButton = SmallButtonNode(title: secondButtonText, buttonState: .BlueOutlined, function: {
            self.firstButton?.setUnselected(node: self.firstButton!)
            self.secondButton?.setSelected(node: self.secondButton!)
        })
        secondButton?.style.width = ASDimensionMake("40%")
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let buttonStack = ASStackLayoutSpec(direction: .horizontal, spacing: 4, justifyContent: .center, alignItems: .center, children: [firstButton!, secondButton!])
        buttonStack.style.width = ASDimensionMake("40%")

        let selectStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .spaceBetween, alignItems: .center, children: [titleLabel, buttonStack])
        selectStack.style.width = ASDimensionMake("100%")
        return selectStack
    }
}
