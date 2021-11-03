//
//  UpcomingMaintenanceDescriptions.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit

class UpcomingMaintenanceDescriptions: ASDisplayNode{
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
        titleNode.attributedText = NSAttributedString(
            string: "10.000 km Service",
            attributes: [
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        
        subTitleNode.attributedText = NSAttributedString(
            string: "Check accu health and 2 others",
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .body),
                .foregroundColor: UIColor.gray])
        
        subTitleNode.attributedText = NSAttributedString(
            string: "This Week",
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor.gray])
        
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [titleNode, subTitleNode])
    }
}
