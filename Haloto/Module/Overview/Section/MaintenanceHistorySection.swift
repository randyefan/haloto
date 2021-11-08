//
//  MaintenanceHistorySection.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 08/11/21.
//

import AsyncDisplayKit

class MaintenanceHistorySection: ASDisplayNode {
    
    let model = sampleMaintenanHistory
    
    private let maintenanHistoryNode: [MaintenanceHistoryCell]

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(model: [MaintenanceHistory]) {
        maintenanHistoryNode = (0 ..< 3).map { index in
            let tempNode = MaintenanceHistoryCell(model: model[index])
            return tempNode
        }
        
        titleNode.attributedText = .font(
            "Maintenance History",
            size: 18,
            fontWeight: .bold,
            color: UIColor.black
        )
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack =  ASStackLayoutSpec(
            direction: .vertical,
            spacing: 14,
            justifyContent: .start,
            alignItems: .stretch,
            children: maintenanHistoryNode
        )
        
        let finalStack =  ASStackLayoutSpec(direction: .vertical, spacing: 11, justifyContent: .start, alignItems: .stretch, children: [titleNode, stack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 14, left: 16, bottom: 14, right: 16), child: finalStack)
    }
}
