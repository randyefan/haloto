//
//  UpcomingMaintenanceCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit

class UpcomingMaintenanceCell: ASDisplayNode{
    private let totalUpcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let upcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 84, height: 78)
        node.backgroundColor = UIColor(red: 126 / 255.0, green: 161 / 255.0, blue: 214 / 255.0, alpha: 1.0)
        return node
    }()
    
    private let descriptionNode: UpcomingMaintenanceDescriptions
    
    override init() {
        totalUpcomingMaintenanceNode.attributedText = NSAttributedString(string: "3",attributes: [.font: UIFont.systemFont(ofSize: 45, weight: .semibold)])
        
        upcomingMaintenanceNode.attributedText = NSAttributedString(string: "Components",
                                                                    attributes: [.font: UIFont.systemFont(ofSize: 9)])
        
        descriptionNode = UpcomingMaintenanceDescriptions()
        super.init()
        automaticallyManagesSubnodes = true
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
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 2, justifyContent: .start, alignItems: .start, children: [totalUpcomingMaintenanceNode, upcomingMaintenanceNode])
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: .infinity, bottom: .infinity, right: .infinity), child: stack)
        
        let background = ASBackgroundLayoutSpec(child: inset, background: backgroundNode)
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .start, alignItems: .start, children: [background, descriptionNode])
    }
}
