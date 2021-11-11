//
//  TextFieldNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/5/21.
//

import AsyncDisplayKit
import UIKit

protocol TextFieldNodeDelegate {
    func didEndEdit(text: String)
}

class TextFieldNode: ASDisplayNode {
    
    var delegate: TextFieldNodeDelegate?
    
    private var titleNode: ASTextNode2?

    private let textFieldNode: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.height = ASDimension(unit: .points, value: 34)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        node.cornerRadius = 6
        node.backgroundColor = UIColor.white
        node.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        node.view.cornerRadius = 6
        node.maximumLinesToDisplay = 1
        node.returnKeyType = .done
        node.textView.font = UIFont(name: "Poppins-Regular", size: 12)
        return node
    }()
    
    

    init(title: String?, placeholder: String, state: TextFieldState) {
        
        if let title = title {
            titleNode = ASTextNode2()
            titleNode?.attributedText = .font(title, size: 11, fontWeight: .medium)
        }
        switch state {
        case .Editable:
            textFieldNode.backgroundColor = UIColor.white
            textFieldNode.attributedPlaceholderText = .font(placeholder, size: 12, color: UIColor.black)
            textFieldNode.borderWidth  = 1
            textFieldNode.borderColor = UIColor.greyApp.cgColor
        case .notEditable:
            textFieldNode.backgroundColor = UIColor.greyApp
            textFieldNode.textView.isEditable = false
            textFieldNode.textView.isSelectable = false
            textFieldNode.attributedText = .font(placeholder, size: 12, color: UIColor.black)
        }
        textFieldNode.attributedPlaceholderText = .font(placeholder, size: 12, color: UIColor.greyApp)
        super.init()
        textFieldNode.delegate = self
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let textFieldWrapper = ASWrapperLayoutSpec(layoutElement: textFieldNode)
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .spaceBetween,
            alignItems: .start,
            children: [titleNode, textFieldWrapper].compactMap{ $0 }
        )
    }
}

extension TextFieldNode: ASEditableTextNodeDelegate {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
                    editableTextNode.resignFirstResponder()
                    return false
                }
                return true
    }
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
        let text = textFieldNode.textView.text
        delegate?.didEndEdit(text: text ?? "")
    }
}
