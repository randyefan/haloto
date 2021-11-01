//
//  MaintenanceHistoryDescription.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit
import Foundation

class MaintenanceHistoryDescription: ASDisplayNode{
    
    private let odometerNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let timeBadgeNode: ASImageNode?
    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let locationBadgeNode: ASImageNode?
    private let workshopNameNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    override init() {
        odometerNode.attributedText = NSAttributedString(string: "10.000 km Service", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        
        timeBadgeNode = ASImageNode()
        timeBadgeNode?.image = UIImage(named: "timeBadge")
        dateNode.attributedText = NSAttributedString(string: "2 Aug 2021", attributes: [.font: UIFont.systemFont(ofSize: 12)])
        
        locationBadgeNode = ASImageNode()
        locationBadgeNode?.image = UIImage(named: "locationBadge")
        workshopNameNode.attributedText = NSAttributedString(string: "Bengkel Gembira", attributes: [.font: UIFont.systemFont(ofSize: 12)])
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let timeAndDateStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [timeBadgeNode, dateNode].compactMap({$0}))

        let locationAndWorkshopStack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [locationBadgeNode, workshopNameNode].compactMap({$0}))
        
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 17, justifyContent: .start, alignItems: .start, children: [timeAndDateStack, locationAndWorkshopStack].compactMap({$0}))

        return ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [odometerNode, stack])
    }
}
