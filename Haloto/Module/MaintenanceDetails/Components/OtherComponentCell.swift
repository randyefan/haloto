//
//  otherCompenentCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 11/11/21.
//

import AsyncDisplayKit

protocol OtherComponenCellDelegate {
    func didEndEdit(text: String)
}

class OtherComponentCell: ASCellNode {
    
    var delegate: OtherComponenCellDelegate?
    
    private let textFieldComponent: ASEditableTextNode = {
        let node = ASEditableTextNode()
        node.style.height = ASDimension(unit: .points, value: 50)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        node.cornerRadius = 6
        node.backgroundColor = UIColor.white
        node.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        node.view.cornerRadius = 6
        node.maximumLinesToDisplay = 1
        node.returnKeyType = .done
        return node
    }()
    
    private let textFieldPrice: ASEditableTextNode = {
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
    
    override init() {
        super.init()
    }
}

extension OtherComponentCell: ASEditableTextNodeDelegate {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
                    editableTextNode.resignFirstResponder()
                    return false
                }
                return true
    }
    func editableTextNodeDidFinishEditing(_ editableTextNode: ASEditableTextNode) {
//        let text = textFieldNode.textView.text
//        delegate?.didEndEdit(text: text ?? "")
    }
}
