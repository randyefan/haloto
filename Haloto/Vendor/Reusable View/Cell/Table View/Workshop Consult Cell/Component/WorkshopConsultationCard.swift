//
//  WorkshopConsultationCard.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit
import UIKit

internal final class WorkshopConsultationCard: ASDisplayNode {
    private let workshopNameNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 1
        node.truncationMode = .byTruncatingTail
        return node
    }()

    private let workshopPriceNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 1
        return node
    }()

    private let ratingStarNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "Star")
        node.style.preferredSize = CGSize(width: 15, height: 15)
        return node
    }()

    private let ratingTextNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.maximumNumberOfLines = 1
        return node
    }()

    private let workshopBackgroundImageNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "Workshop Background Default")
        node.contentMode = .scaleToFill
        node.cornerRadius = 15
        return node
    }()

    private let overlayNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.alpha = 0.9
        return node
    }()

    private var workshopSpecialityNodes = [ChipNode]()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true

        workshopNameNode.attributedText = .font("Harapan Jaya Abadi", size: 18, fontWeight: .bold, color: .white)
        workshopPriceNode.attributedText = .font("Rp 15.000, -", size: 11, fontWeight: .medium, color: .white)
        ratingTextNode.attributedText = .font("4,3 | (50)", size: 11, fontWeight: .medium, color: .white)
        workshopSpecialityNodes = [ChipNode("engine"), ChipNode("tires"), ChipNode("brio")]
    }

    override func layout() {
        super.layout()
        cornerRadius = 15
        style.minHeight = ASDimensionMake(126)

        let CALayer = CAGradientLayer.init()
        CALayer.cornerRadius = 15
        CALayer.setGradientLayerForBackgroundHome(view: overlayNode.view, color1: .clear, color2: .blueApp)
        overlayNode.view.layer.insertSublayer(CALayer, at: 0)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let ratingStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 4,
            justifyContent: .start,
            alignItems: .start,
            children: [ratingStarNode, ratingTextNode]
        )

        let chipStack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 10,
            justifyContent: .start,
            alignItems: .start,
            children: workshopSpecialityNodes
        )

        let finalStack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 6,
            justifyContent: .start,
            alignItems: .stretch,
            children: [workshopNameNode, workshopPriceNode, ratingStack, chipStack]
        )

        let insetSpec = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 10, left: 118, bottom: 16, right: 24),
            child: finalStack
        )

        let backgroundSpec = ASBackgroundLayoutSpec(child: overlayNode, background: workshopBackgroundImageNode)
        return ASBackgroundLayoutSpec(child: insetSpec, background: backgroundSpec)
    }
}
