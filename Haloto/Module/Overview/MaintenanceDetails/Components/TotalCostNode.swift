//
//  TotalCostNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 12/11/21.
//

import AsyncDisplayKit

class TotalCostNode: ASDisplayNode {
    let titleCostNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Total Cost", size: 18, fontWeight: .regular)
        return node
    }()
    
    let totalCostNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    init(model: MaintenanceHistory) {
        totalCostNode.attributedText = .font("Rp \(model.totalCost ?? 0)", size: 18, fontWeight: .bold, alignment: .right)
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [titleCostNode, totalCostNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: stack)
    }
}
