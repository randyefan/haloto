//
//  WrapperSelectNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 11/11/21.
//

import AsyncDisplayKit
import Kingfisher

internal final class WrapperSelectNode: ASCellNode {
    private let selectNode: SelectNode
    
    init(placeHolder: String, function: (() -> Void)?) {
        selectNode = SelectNode(placeholder: placeHolder)
        super.init()
        automaticallyManagesSubnodes = true
        style.height = ASDimensionMake(50)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: selectNode)
    }
    
}
