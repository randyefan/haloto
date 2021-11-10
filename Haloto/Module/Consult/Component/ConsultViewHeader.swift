//
//  ConsultViewHeader.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit

internal final class ConsultViewHeader: ASDisplayNode {
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Consultation", size: 18, fontWeight: .bold)
        return node
    }()

    private let chatHistoryButtoNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "Chat History")
        node.style.preferredSize = CGSize(width: 40, height: 40)
        return node
    }()

    private let filterButonNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "Filter")
        node.style.preferredSize = CGSize(width: 40, height: 40)
        return node
    }()


    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        setShadow()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let buttonStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 2,
            justifyContent: .start,
            alignItems: .stretch,
            children: [chatHistoryButtoNode, filterButonNode]
        )

        let finalStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [titleNode, buttonStack]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 20, bottom: 5, right: 20), child: finalStack)
    }

    override func layout() {
        super.layout()
        backgroundColor = .white
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    func setShadow() {
        cornerRadius = 10
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }
}
