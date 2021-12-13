//
//  ReusableVehicleCell.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import Foundation
import AsyncDisplayKit
import UIKit
import SwiftUI

class VehicleCellNode: ASCellNode {
    private var vehicleDescriptionNode: VehicleDescriptionNode?
    private var vehicleImageNode: VehicleImageNode?
    private let cellNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.cornerRadius = 23
        return node
    }()
    private var backgroundNode: ASDisplayNode?
    private var addImageNode: ASImageNode?

    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    init(model: CarVehicle?) {
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
        backgroundColor = .white
        style.height = ASDimension(unit: ASDimensionUnit.points, value: 196)
        setShadow(node: cellNode)
        
        if let model = model {
            vehicleImageNode = VehicleImageNode()
            vehicleDescriptionNode = VehicleDescriptionNode(model: model)
            vehicleImageNode?.style.flexShrink = 1
        } else {
            addImageNode = ASImageNode()
            backgroundNode = ASImageNode()
            addImageNode?.image = UIImage(named: "add-car-placeholder")
            textNode.attributedText = .font(
                "add new car",
                size: 16,
                fontWeight: .medium,
                color: UIColor.blueApp,
                alignment: .center,
                isTitle: false
            )
        }
    }

    func setShadow(node: ASDisplayNode) {
        node.clipsToBounds = false
        node.shadowOffset = CGSize(width: 0, height: 0)
        node.shadowColor = UIColor.black.cgColor
        node.shadowOpacity = 0.10
    }

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let addNewStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .center,
            alignItems: .center,
            children: [self.addImageNode, self.textNode].compactMap{ $0 }
        )
        
        let vehicleStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [self.vehicleDescriptionNode, self.vehicleImageNode].compactMap{ $0 }
        )
        
        vehicleStack.style.flexShrink = 1
        
        let cellStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .center,
            alignItems: .center,
            children: [addNewStack, vehicleStack].compactMap{ $0 }
        )
        
        let cell = ASBackgroundLayoutSpec(child: cellStack, background: cellNode)

        let cellInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4), child: cell)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: cellInset)
    }
}
