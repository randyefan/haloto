//
//  WrapperTextfieldOther.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import AsyncDisplayKit
import Kingfisher

internal final class WrapperTextfieldOther: ASCellNode {
    private let otherTextfield: TextFieldOthers
    
    override init() {
        otherTextfield = TextFieldOthers()
        super.init()
        automaticallyManagesSubnodes = true
        style.height = ASDimensionMake(50)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: otherTextfield)
    }
    
}
