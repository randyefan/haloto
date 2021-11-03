//
//  AddNewVehicleCellNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/3/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

class AddNewVehicleCellNode: ASCellNode {
    private let addImageNode: ASImageNode = {
        let node = ASImageNode()
        return node
    }()
    
    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    override init() {
        addImageNode.image = UIImage(named: "add-car-placeholder")
        textNode.attributedText = .font("add new car", size: 16, fontWeight: .medium, color: UIColor.appBlue, alignment: .center, isTitle: false)
        super.init()
        automaticallyManagesSubnodes = true
        backgroundColor = .white
        style.height = ASDimension(unit: ASDimensionUnit.points, value: 180)
        setShadow()
    }
    
    func setShadow() {
        clipsToBounds = false
        cornerRadius = 23
        shadowOffset = CGSize(width: 0, height: 0)
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.10
    }
    
    override func layout() {
        super.layout()
        // Optimize performance for rendering shadow
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [addImageNode, textNode])
    }
}
