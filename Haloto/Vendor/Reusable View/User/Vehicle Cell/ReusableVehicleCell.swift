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
    private let vehicleDescriptionNode : VehicleDescriptionNode
    private let vehicleImageNode : VehicleImageNode
    
    init(model: Vehicle){
        vehicleImageNode = VehicleImageNode()
        vehicleDescriptionNode = VehicleDescriptionNode(model: model)
        vehicleDescriptionNode.style.flexShrink = 1
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        style.height = ASDimension(unit: ASDimensionUnit.points, value: 180)
        setShadow()
    }
    
    func setShadow() {
        clipsToBounds = false
        cornerRadius = 23
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.10
    }
    
    override func layout() {
        super.layout()
        // Optimize performance for rendering shadow
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let HStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [vehicleDescriptionNode, vehicleImageNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: HStack)
    }
}
