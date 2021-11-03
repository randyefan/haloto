//
//  ReusableSmallButtonNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import AsyncDisplayKit
import UIKit

class SmallYellowButtonNode: ASDisplayNode {
    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor(named: "button-yellow")
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 44)
        node.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return node
    }()

    init(title: String) {
        buttonNode.setTitle(title, with: UIFont(name: "Poppins-Medium.ttf", size: 11), with: UIColor(named: "button-title-dark"), for: .normal)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: buttonNode)
    }
}

class SmallBlueButtonNode: ASDisplayNode {
    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.backgroundColor = UIColor(named: "button-blue")
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 44)
        node.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)

        return node
    }()

    init(title: String) {
        buttonNode.setTitle(title, with: UIFont(name: "Poppins-Medium.ttf", size: 11), with: UIColor(named: "button-title-light"), for: .normal)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: buttonNode)
    }
}

class SmallOutlineButtonNode: ASDisplayNode {
    let buttonNode: ASButtonNode = {
        let node = ASButtonNode()
        node.borderWidth = 2
        node.borderColor = UIColor(named: "button-blue")?.cgColor
        node.cornerRadius = 20
        node.style.height = ASDimension(unit: ASDimensionUnit.points, value: 44)
        node.contentEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return node
    }()

    init(title: String) {
        buttonNode.setTitle(title, with: UIFont(name: "Poppins-Medium.ttf", size: 11), with: UIColor(named: "button-blue"), for: .normal)
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: buttonNode)
    }
}
