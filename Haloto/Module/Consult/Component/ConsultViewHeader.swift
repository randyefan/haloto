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
        node.style.preferredSize = CGSize(width: 30, height: 30)
        return node
    }()

    private let chatHistoryButtonTextNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Chat History", size: 11, fontWeight: .medium, color: UIColor(hexString: "#B6B6B6"))
        return node
    }()

    private let filterButonNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "Filter")
        node.style.preferredSize = CGSize(width: 30, height: 30)
        return node
    }()

    private let filterButtonTextNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Filter", size: 11, fontWeight: .medium, color: UIColor(hexString: "#B6B6B6"))
        return node
    }()


    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        setShadow()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let chatHistoryButtonStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .center,
            alignItems: .center,
            children: [chatHistoryButtoNode, chatHistoryButtonTextNode]
        )

        let filterButtonStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .center,
            alignItems: .center,
            children: [filterButonNode, filterButtonTextNode]
        )

        let buttonStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 12,
            justifyContent: .start,
            alignItems: .stretch,
            children: [chatHistoryButtonStack, filterButtonStack]
        )

        let finalStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [titleNode, buttonStack]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 20, bottom: 20, right: 20), child: finalStack)
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
