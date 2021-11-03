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
        node.maximumNumberOfLines = 2
        return node
    }()

    private let dateNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.style.alignSelf = .end
        return node
    }()

    override init() {
        titleNode.attributedText = NSAttributedString(string: "10.000 km Service",
                                                      attributes: [
                                                          .font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                                      ])

        subTitleNode.attributedText = NSAttributedString(string: "Check accu health and 2 other",
                                                         attributes: [
                                                             .font: UIFont.systemFont(ofSize: 12),
                                                             .foregroundColor: UIColor.lightGray,
                                                         ])

        dateNode.attributedText = NSAttributedString(string: "This Week",
                                                     attributes: [
                                                         .font: UIFont.preferredFont(forTextStyle: .caption1),
                                                     ])
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical,
                                      spacing: 5,
                                      justifyContent: .start,
                                      alignItems: .start,
                                      children: [titleNode, subTitleNode])

        let finalStack =  ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [stack, dateNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 16), child: finalStack)
    }
}
