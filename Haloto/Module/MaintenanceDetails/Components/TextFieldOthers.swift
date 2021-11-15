//
//  TextFieldOthers.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 12/11/21.
//

import AsyncDisplayKit

//protocol OtherTextFieldDelegate {
//    func didInputName(text: String)
//    func didInputPrice(text: String)
//}

class TextFieldOthers: ASDisplayNode {
    
//    var delegate: OtherTextFieldDelegate
    
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
        node.style.height = ASDimensionMake(50)
        node.borderColor = UIColor.greyApp.cgColor
        node.borderWidth = 1
        node.cornerRadius = 6
        return node
    }()

    override init() {
        super.init()
//        textFieldNameNode.delegate = self
//        textFieldPriceNode.delegate = self
        automaticallyManagesSubnodes = true
        setDisplay()
    }

    func setDisplay() {
        style.height = ASDimensionMake(50)
        borderColor = UIColor.greyApp.cgColor
        borderWidth = 1
        cornerRadius = 6
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [textFieldNameNode, textFieldPriceNode])
        
        let stackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8), child: stack)

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: stackInset)
    }
}

//extension TextFieldOthers: ASEditableTextNodeDelegate {
//
//}
