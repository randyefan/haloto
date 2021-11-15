//
//  TextFieldNode.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import Foundation
protocol EntryTextFieldNodeDelegate: AnyObject {
    func textFieldIsTapped()
}

class EntryTextFieldNode: ASDisplayNode {
    var delegate: EntryTextFieldNodeDelegate?
    private var isPicker: Bool = false
    private var text: String = ""
    private var placeholder: String = ""
    private var keyboardType: UIKeyboardType = .default
    private lazy var textField: ASEditableTextNode = {
        let field = ASEditableTextNode()
        if isPicker {
            field.attributedText = .font(text, size: 12, fontWeight: .regular, color: .black, alignment: .center)
        } else {
            field.attributedPlaceholderText = .font(placeholder, size: 12, fontWeight: .regular, color: UIColor(hexString: "B6B6B6"), alignment: .center)
            field.textView.font = UIFont(name: "Poppins-Medium", size: 12)
            field.keyboardType = keyboardType
        }
        field.textView.textContainer.maximumNumberOfLines = 1
        field.textView.textContainer.lineBreakMode = .byTruncatingTail
        return field
    }()

    override func layout() {
        borderColor = UIColor.greyApp.cgColor
        shadowColor = UIColor.blackApp.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 0
        shadowRadius = 4
        borderWidth = 1
        cornerRadius = 5

        super.layout()
    }

    init(isPicker: Bool, text: String, placeholder: String, keyboardType: UIKeyboardType) {
        self.isPicker = isPicker
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init()

        if isPicker{
            textField.textView.isEditable = false
            textField.textView.isSelectable = false
        }
        self.view.onTap {
            self.delegate?.textFieldIsTapped()
        }
        automaticallyManagesSubnodes = true
    }

    func changeText(text: String) {
        textField.attributedText = .font(text, size: 12, fontWeight: .regular, color: .black, alignment: .center)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10), child: textField)
    }
}

extension EntryTextFieldNode: ASEditableTextNodeDelegate{
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textField.textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
         return numberOfChars < 8;
    }
}
