//
//  MaintenanceHistoryCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit

class MaintenanceHistoryCell: ASCellNode{
    
    private let maintenanceHistoryImage: ASImageNode?
    
    private let descriptionNode: MaintenanceHistoryDescription
    
    override init() {
        maintenanceHistoryImage = ASImageNode()
        maintenanceHistoryImage?.image = UIImage(named: "struckImage")
        maintenanceHistoryImage?.style.preferredSize = CGSize(width: 48, height: 48)
        maintenanceHistoryImage?.cornerRadius = 25
        
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
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [maintenanceHistoryImage, descriptionNode].compactMap({$0}))
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 5, bottom: 20, right: .infinity), child: stack)
    }
}
