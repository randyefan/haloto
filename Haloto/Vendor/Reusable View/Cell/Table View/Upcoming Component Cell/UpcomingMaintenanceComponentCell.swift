//
//  UpcomingMaintenanceCell.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/9/21.
//

import AsyncDisplayKit
import UIKit

class UpcomingMaintenanceComponentCell: ASCellNode {
    private let componentImageNode: ASNetworkImageNode = {
       let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 48, height: 48)
        node.cornerRadius = 48/2
        return node
    }()
    
    private let backgroundNode = ASDisplayNode()
    private let cellNode = ASDisplayNode()
    private var componentNameNode = ASTextNode2()
    private var dateNode = ASTextNode()

    init(component: Component, date: String) {
        componentImageNode.image = UIImage(named: "component-image-placeholder")

        componentNameNode.attributedText = .font("\(component.name ?? "")", size: 13, fontWeight: .medium)
        dateNode.attributedText = .font(" \(date)", size: 12, fontWeight: .regular)
        super.init()
        automaticallyManagesSubnodes = true
        cellNode.backgroundColor = .white
        style.height = ASDimension(unit: .points, value: 88)
        style.width = ASDimension(unit: .fraction, value: 1)
        setShadow(cellNode)
    }

    func setShadow(_ node: ASDisplayNode) {
        node.clipsToBounds = false
        node.cornerRadius = 8
        node.shadowColor = UIColor.black.cgColor
        node.shadowOpacity = 0.12
        node.shadowOffset.height = 0
        node.shadowRadius = 3
    }

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let titleStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .start,
            children: [componentNameNode, dateNode]
        )
        
        let cellStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 8,
            justifyContent: .start,
            alignItems: .center,
            children: [componentImageNode, titleStack]
        )
        
        let cellInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: cellStack)
        
        let cell = ASBackgroundLayoutSpec(child: cellInset, background: cellNode)
        
        let cellFinalInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4), child: cell)
        
        return ASBackgroundLayoutSpec(child: cellFinalInset, background: backgroundNode)
    }
}
