//
//  MaintenanceHistoryCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit

class MaintenanceHistoryCell: ASDisplayNode{
    
//    private let maintenanceHistoryImage: ASImageNode = {
//        let node = ASImageNode()
//        node.style.preferredSize = CGSize(width: 48, height: 48)
//        node.cornerRadius = 14
//        return node
//    }()
    
    let backgroundNode: ASDisplayNode
    
    private let descriptionNode: MaintenanceHistoryDescription
    
    override init() {
        backgroundNode = ASDisplayNode()
        backgroundNode.style.preferredSize = CGSize(width: 48, height: 48)
        backgroundNode.backgroundColor = .lightGray
        backgroundNode.cornerRadius = 25
        
        descriptionNode = MaintenanceHistoryDescription()
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        setShadow()
    }
    
    func setShadow(){
        clipsToBounds = false
        cornerRadius = 8
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }
    
    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [backgroundNode, descriptionNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 8, bottom: 20, right: 8), child: stack)
    }
}
