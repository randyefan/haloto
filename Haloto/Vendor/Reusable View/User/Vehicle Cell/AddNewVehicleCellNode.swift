//
//  AddNewVehicleCellNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/3/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

class AddNewVehicleCellNode: ASCellNode {
    private let cellNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.cornerRadius = 23
        return node
    }()

    private let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        return node
    }()

    private let addImageNode: ASImageNode = {
        let node = ASImageNode()
        return node
    }()

    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    override init() {
        

        super.init()
        style.height = ASDimension(unit: ASDimensionUnit.points, value: 196)
        automaticallyManagesSubnodes = true
        setShadow(node: cellNode)
        selectionStyle = .none
    }

    func setShadow(node: ASDisplayNode) {
        node.clipsToBounds = false
        node.shadowOffset = CGSize(width: 0, height: 0)
        node.shadowColor = UIColor.black.cgColor
        node.shadowOpacity = 0.10
    }

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let cellStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .center,
            alignItems: .center,
            children: [addImageNode, textNode]
        )

        let cell = ASBackgroundLayoutSpec(child: cellStack, background: cellNode)

        let cellInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4), child: cell)

        return ASBackgroundLayoutSpec(child: cellInset, background: backgroundNode)
    }
}
