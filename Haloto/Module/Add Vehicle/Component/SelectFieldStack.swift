//
//  SelectNode.swift
//  Haloto
//
//  Created by Javier Fransiscus on 09/11/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

protocol SelectFieldStackDelegate: AnyObject{
    func selectFieldDidTapped(_ sender: SelectFieldStack)
}

class SelectFieldStack: ASDisplayNode {
    private var placeholderText: String = ""
    var isFilled = false
    var delegate: SelectFieldStackDelegate?
    var title: String = ""
    private lazy var titleLabel: ASTextNode2 = {
        let node = ASTextNode2()

        return node
    }()

    private lazy var selectNode: SelectNode = {
        let node = SelectNode(placeholder: placeholderText)
        //TODO: add tap gesture recognizer
      
        return node
    }()
    
    override func layout(){
        super.layout()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectFieldDidTapped))
        view.addGestureRecognizer(gesture)
    }

    init(title: String, placeholder: String) {
        self.title = title
        placeholderText = placeholder
        super.init()
        titleLabel.attributedText = .font(title, size: 18, fontWeight: .bold, color: .black)
        automaticallyManagesSubnodes = true
    }
    
    func setSelected(text: String?) {
        selectNode.setSelected(text: text)
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let selectStack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .start, alignItems: .start, children: [titleLabel, selectNode])
        return selectStack
    }
}

extension SelectFieldStack{
    @objc
    func selectFieldDidTapped(){
        delegate?.selectFieldDidTapped(self)
    }
    
}
