//
//  UpcomingMaintenanceDescription.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import AsyncDisplayKit

class UpcomingMaintenanceDescription: ASCellNode {
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let subTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    override init() {
        titleNode.attributedText = NSAttributedString(string: "10.000 km Service",
                                                      attributes: [
                                                        .font: UIFont.systemFont(ofSize: 14, weight: .medium)
                                                      ])
        
        subTitleNode.attributedText = NSAttributedString(string: "Check accu health and 2 others",
                                                      attributes: [
                                                        .font: UIFont.preferredFont(forTextStyle: .body),
                                                        .foregroundColor: UIColor.lightGray
                                                      ])
        
        dateNode.attributedText = NSAttributedString(string: "This Week",
                                                     attributes: [
                                                        .font: UIFont.preferredFont(forTextStyle: .caption1)
                                                     ])
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical,
                                      spacing: 5,
                                      justifyContent: .start,
                                      alignItems: .start,
                                      children: [titleNode, subTitleNode])
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 90,
                                                           left: 50,
                                                           bottom: 5,
                                                           right: 5),
                                      child: dateNode)
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: 5,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [stack, inset])
    }
}
