//
//  CellContentListPopUpNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 03/11/21.
//

import AsyncDisplayKit
import Foundation

class CellContentListPopUpNode: ASCellNode {
    // MARK: - Variable

    let title: ASTextNode2
    var node = ASDisplayNode()

    // MARK: - Computed Properties

    var state: Bool = false {
        didSet {
            if state {
                node.backgroundColor = UIColor.blueApp
            } else {
                node.backgroundColor = .white
            }
        }
    }

    override var isSelected: Bool {
        didSet {
            state = !state
        }
    }

    // MARK: - Initializer

    init(model: String) {
        title = ASTextNode2()

        super.init()
        automaticallyManagesSubnodes = true

        title.attributedText = .font("\(model)", size: 12)

        selectionStyle = .none
        style.height = ASDimension(unit: .points, value: 40)

        node.borderColor = UIColor.greyApp.cgColor
        node.style.preferredSize = CGSize(width: 21, height: 21)
        node.borderWidth = 1
        node.cornerRadius = 21 / 2
        node.backgroundColor = .white
    }

    // MARK: - Layout Specs

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal,
                                      spacing: 0,
                                      justifyContent: .spaceBetween,
                                      alignItems: .center,
                                      children: [title, node])

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0),
                                 child: stack)
    }
}
