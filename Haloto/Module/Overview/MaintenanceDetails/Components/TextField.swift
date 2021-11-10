//
//  TextField.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

protocol TextFieldDelegate {
    func didEndEdit(text: String)
}

class TextField: ASDisplayNode {
    var delegate: TextFieldDelegate?

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

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
        return node
    }()

    init(title: String, placeholder: String, state: TextFieldState) {
        titleNode.attributedText = .font(title, size: 11, fontWeight: .medium)
        switch state {
        case .Editable:
            textFieldNode.backgroundColor = UIColor.white
            textFieldNode.attributedPlaceholderText = .font(placeholder, size: 12, color: UIColor.black)
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
            children: [titleNode, textFieldWrapper]
        )
    }
}

extension TextField: ASEditableTextNodeDelegate {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn _: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            return false
        }
        return true
    }

    func editableTextNodeDidFinishEditing(_: ASEditableTextNode) {
        let text = textFieldNode.textView.text
        delegate?.didEndEdit(text: text ?? "")
    }
}
