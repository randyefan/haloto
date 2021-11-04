//
//  ButtonDeleteFilterMaintenance.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 04/11/21.
//

import AsyncDisplayKit

class ButtonDeleteFilterMaintenance: ASCellNode {
    private let deleteButton: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "buttonDelete")
        node.style.preferredSize = CGSize(width: 16, height: 16)
        return node
    }()
    
    init(target: Any, function: Selector){
        deleteButton.addTarget(target, action: function, forControlEvents: .touchUpInside)
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASWrapperLayoutSpec(layoutElement: deleteButton)
    }
}
