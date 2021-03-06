//
//  TextFieldPickerNode.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

protocol FormFieldStackDelegate: AnyObject {
    func openPickerView(sender: FormFieldStack)
}

class FormFieldStack: ASDisplayNode {
    var delegate: FormFieldStackDelegate?
    private var isPicker: Bool = false
    private var title: String = ""
    var text: String = ""
    private var placeholder: String = ""
    private var keyboardType: UIKeyboardType = .default
    private var options: [String] = [""]


    private lazy var titleLabel: ASTextNode2 = {
        let label = ASTextNode2()
        return label
    }()

    private lazy var textField: EntryTextFieldNode = {
        let field = EntryTextFieldNode(isPicker: isPicker, text: text, placeholder: placeholder, keyboardType: keyboardType)
        return field
    }()

    init(isPicker: Bool, title: String, text: String? = "", placeholder: String? = "", keyboardType: UIKeyboardType? = .default, pickerOptions: [String]? = ["no data is set"]) {
        self.isPicker = isPicker
        self.title = title
        self.text = text ?? ""
        self.placeholder = placeholder ?? ""
        self.keyboardType = keyboardType ?? .default
        self.options = pickerOptions ?? ["empty"]
        super.init()
        textField.delegate = self
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold)
        style.width = ASDimensionMake("100%")
        automaticallyManagesSubnodes = true
    }

    func changeText(text: String) {
        self.text = text
        textField.changeText(text: text)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .center, children: [titleLabel, textField])
        return stack
    }
}

extension FormFieldStack: EntryTextFieldNodeDelegate {
    func getTextInputValue(_ input: String) {
        self.text = input
    }

    func textFieldIsTapped() {
        delegate?.openPickerView(sender: self)
    }

    func getOptions() -> [String] {
        return options
    }

    func getDefaultValue() -> String {
        return text
    }
}
