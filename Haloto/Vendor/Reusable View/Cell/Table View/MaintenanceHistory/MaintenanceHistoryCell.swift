//
//  MaintenanceHistoryCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 01/11/21.
//

import AsyncDisplayKit

class MaintenanceHistoryCell: ASDisplayNode {
    private let maintenanceHistoryImage: ASImageNode = {
       let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 48, height: 48)
        node.cornerRadius = 25
        return node
    }()

    private let descriptionNode: MaintenanceHistoryDescription

    init(model: CarMaintenanceHistory) {
        if let data = model.image {
            maintenanceHistoryImage.image = UIImage(data: data)
        }

        descriptionNode = MaintenanceHistoryDescription(model: model)
        descriptionNode.style.flexShrink = 1
        descriptionNode.style.flexGrow = 1

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

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 8, justifyContent: .start, alignItems: .start, children: [maintenanceHistoryImage, descriptionNode].compactMap { $0 })

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 5, bottom: 20, right: .infinity), child: stack)
    }
}
