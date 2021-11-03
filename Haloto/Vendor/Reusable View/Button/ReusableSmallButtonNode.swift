//
//  ReusableSmallButtonNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import AsyncDisplayKit
import UIKit

class SmallYellowButtonNode: ASDisplayNode {
    private let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.buttonYellow
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 36)
        node.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        return node
    }()


    init(title: String, target: Any, function: Selector) {
        buttonNode.titleNode.attributedText = .font(title, size: 11, fontWeight: .medium)
        buttonNode.addTarget(target, action: function, forControlEvents: .touchUpInside)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: buttonNode)
    }
}

class SmallBlueButtonNode: ASDisplayNode {
    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor.appBlue
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 36)
        node.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        return node
    }()


    init(title: String, target: Any, function: Selector) {
        buttonNode.titleNode.attributedText = .font(
            title,
            size: 11,
            fontWeight: .medium,
            color: UIColor.white
        )
        buttonNode.addTarget(target, action: function, forControlEvents: .touchUpInside)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: buttonNode)
    }
}

class SmallOutlineButtonNode: ASDisplayNode {
    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.borderWidth = 2
        node.borderColor = UIColor.appBlue.cgColor
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 46)
        node.contentEdgeInsets = UIEdgeInsets.init(top: 5, left: 10, bottom: 5, right: 10)
        return node
    }()

    init(title: String, target: Any, function: Selector) {
        buttonNode.titleNode.attributedText = .font(
            title,
            size: 11,
            fontWeight: .medium,
            color: UIColor.appBlue
        )
        buttonNode.addTarget(target, action: function, forControlEvents: .touchUpInside)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: buttonNode)
    }
}
