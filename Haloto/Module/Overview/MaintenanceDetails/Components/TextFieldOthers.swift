//
//  TextFieldOthers.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 12/11/21.
//

import AsyncDisplayKit

class TextFieldOthers: ASDisplayNode {
    
    private let textFieldNameNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.height = ASDimension(unit: .points, value: 34)
        node.style.width = ASDimension(unit: .points, value: 250)
        node.backgroundColor = UIColor.white
        node.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        node.maximumLinesToDisplay = 1
        node.returnKeyType = .done
        node.attributedPlaceholderText = .font("Other Expenses", size: 12)
        return node
    }()
    
    
    private let textFieldPriceNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.height = ASDimension(unit: .points, value: 34)
        node.cornerRadius = 6
        node.backgroundColor = UIColor.white
        node.textContainerInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        node.view.cornerRadius = 6
        node.maximumLinesToDisplay = 1
        node.returnKeyType = .done
        node.attributedPlaceholderText = .font("input price", size: 12)
        return node
    }()
    
    private let background: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimensionMake(60)
        node.clipsToBounds = false
        node.cornerRadius = 6
        node.shadowColor = UIColor.black.cgColor
        node.shadowOpacity = 0.12
        node.shadowOffset.height = 2
        node.shadowRadius = 4
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [textFieldNameNode, textFieldPriceNode])
        
        let insetStack = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), child: stack)
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: background)
        
        return ASOverlayLayoutSpec(child: inset, overlay: insetStack)
    }
    
}
