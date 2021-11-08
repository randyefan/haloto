//
//  ReusableSmallButtonNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import AsyncDisplayKit
import UIKit

class SmallButtonNode: ASDisplayNode {
    private let buttonNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.buttonYellow
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 36)
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(title: String, buttonState: ButtonState = .Yellow, function: (() -> Void)?) {
        switch buttonState {
        case .Yellow:
            titleNode.attributedText = .font(title, size: 11, fontWeight: .medium)
            buttonNode.backgroundColor = UIColor.buttonYellow
            buttonNode.view.onTap(action: function)
        case .Blue:
            titleNode.attributedText = .font(title, size: 11, fontWeight: .medium, color: UIColor.white)
            buttonNode.backgroundColor = UIColor.blueApp
            buttonNode.view.onTap(action: function)
        case .BlueOutlined:
            titleNode.attributedText = .font(title, size: 11, fontWeight: .medium, color: UIColor.blueApp)
            buttonNode.backgroundColor = UIColor.white
            buttonNode.borderWidth = 2
            buttonNode.borderColor = UIColor.blueApp.cgColor
            buttonNode.view.onTap(action: function)
        case .Disabled:
            titleNode.attributedText = .font(title, size: 11, fontWeight: .medium)
            buttonNode.backgroundColor = UIColor.greyApp
        }
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let titleInset = ASInsetLayoutSpec(insets: UIEdgeInsets(
            top: .infinity,
            left: .infinity,
            bottom: .infinity,
            right: .infinity
        ),
        child: titleNode)
        return ASOverlayLayoutSpec(child: buttonNode, overlay: titleInset)
    }
}
