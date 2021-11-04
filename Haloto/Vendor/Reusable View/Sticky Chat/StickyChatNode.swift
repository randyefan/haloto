//
//  StickyChatNode.swift
//  Haloto
//
//  Created by darindra.khadifa on 04/11/21.
//

import AsyncDisplayKit

internal final class StickyChatNode: ASDisplayNode {

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font(
            "On Going Consultation",
            size: 12,
            fontWeight: .medium,
            color: .blueApp,
            alignment: .center,
            underline: true
        )
        return node
    }()

    private let workshopImageNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.backgroundColor = .black
        node.style.preferredSize = CGSize(width: 36, height: 36)
        node.cornerRadius = 36 / 2
        return node
    }()

    private let workshopNameNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let statusChatNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let timeNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true

        workshopNameNode.attributedText = .font("Bengkel Martin", size: 13, fontWeight: .bold)
        statusChatNode.attributedText = .font("Awaiting Workshop Approval", size: 12, color: .blackApp)
        timeNode.attributedText = .font("4m ago", size: 10, color: .secondaryGreyApp)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let profileStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 0,
            justifyContent: .start,
            alignItems: .stretch,
            children: [workshopNameNode, statusChatNode]
        )

        let leftWorkshopStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .start,
            alignItems: .center,
            children: [workshopImageNode, profileStack]
        )

        let finalWorkshopStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .stretch,
            children: [leftWorkshopStack, timeNode]
        )

        let finalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 16,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleNode, finalWorkshopStack]
        )

        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: finalStack)
    }

    override func layout() {
        super.layout()
        backgroundColor = .white
        setShadow()
    }

    private func setShadow() {
        clipsToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
        cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
