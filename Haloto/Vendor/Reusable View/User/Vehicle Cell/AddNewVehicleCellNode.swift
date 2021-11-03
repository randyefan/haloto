//
//  AddNewVehicleCellNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/3/21.
//

import Foundation
import AsyncDisplayKit
import UIKit

class AddNewVehicleCellNode: ASCellNode {
    
    private let addImageNode : ASImageNode = {
        let node = ASImageNode()
        return node
    }()
    
    private let textNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    override init(){
        addImageNode.image = UIImage(named: "add-car-placeholder")
        textNode.attributedText = NSAttributedString(string: "add new vehicle", attributes:[
                                                            .font : UIFont.systemFont(ofSize: 16, weight: .medium),
                                                            .foregroundColor : UIColor(named: "button-blue")
                                                        ]
                                                    )
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
        return ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .center, children: [addImageNode, textNode])
    }
}
