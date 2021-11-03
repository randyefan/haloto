//
//  VehicleImageNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/2/21.
//

import Foundation
import AsyncDisplayKit
import UIKit

class VehicleImageNode : ASDisplayNode {
    
    private let imageNode : ASImageNode = {
        let node = ASImageNode()
        node.cornerRadius = 23
        return node
    }()
    
    override init() {
        imageNode.image = UIImage(named: "vehicle-image-placeholder")
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: imageNode)
    }
}
