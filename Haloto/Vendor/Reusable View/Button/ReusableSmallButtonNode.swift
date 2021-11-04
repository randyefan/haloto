//
//  ReusableSmallButtonNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import AsyncDisplayKit
import UIKit

class SmallYellowButtonNode: ASDisplayNode {
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

    init(title: String, function: (() -> Void)?) {
        titleNode.attributedText = .font(title, size: 11, fontWeight: .medium)
        buttonNode.view.onTap(action: function)
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

class SmallBlueButtonNode: ASDisplayNode {
    private let buttonNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.blueApp
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 36)
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(title: String, function: (() -> Void)?) {
        titleNode.attributedText = .font(title, size: 11, fontWeight: .medium, color: UIColor.white)
        buttonNode.view.onTap(action: function)
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

class SmallOutlineButtonNode: ASDisplayNode {
    let buttonNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.white
        node.borderWidth = 2
        node.borderColor = UIColor.blueApp.cgColor
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 36)
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(title: String, function: (() -> Void)?) {
        titleNode.attributedText = .font(title, size: 11, fontWeight: .medium , color: UIColor.blueApp)
        buttonNode.view.onTap(action: function)
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
