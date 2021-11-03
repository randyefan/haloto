//
//  UpcomingMaintenanceCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 02/11/21.
//

import AsyncDisplayKit
import UIKit

class UpcomingMaintenanceCell: ASCellNode {
    private let countUpcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let upcomingMaintenanceNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let backgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        return node
    }()

    let upcomingMaintenanceDescription: UpcomingMaintenanceDescription

    override init() {
        countUpcomingMaintenanceNode.attributedText = NSAttributedString(string: "3",
                                                                         attributes: [
                                                                             .font: UIFont.systemFont(ofSize: 45, weight: .semibold),
                                                                             .foregroundColor: UIColor.white,
                                                                         ])

        upcomingMaintenanceNode.attributedText = NSAttributedString(string: "Components",
                                                                    attributes: [
                                                                        .font: UIFont.systemFont(ofSize: 9, weight: .regular),
                                                                        .foregroundColor: UIColor.white,
                                                                    ])

        backgroundNode.style.preferredSize = CGSize(width: 84, height: 78)
        backgroundNode.backgroundColor = UIColor(red: 126 / 255.0,
                                                 green: 161 / 255.0,
                                                 blue: 214 / 255.0,
                                                 alpha: 1.0)

        upcomingMaintenanceDescription = UpcomingMaintenanceDescription()
        upcomingMaintenanceDescription.style.width = ASDimension(unit: .fraction, value: 1)
        upcomingMaintenanceDescription.style.flexShrink = 1

        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        setShadow()
    }

    func setShadow() {
        clipsToBounds = false
        cornerRadius = 8
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: -5, justifyContent: .center, alignItems: .center, children: [countUpcomingMaintenanceNode, upcomingMaintenanceNode])

        let backgroundInset = ASOverlayLayoutSpec(child: backgroundNode, overlay: stack)
        

        return ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [backgroundInset, upcomingMaintenanceDescription])
    }
}
