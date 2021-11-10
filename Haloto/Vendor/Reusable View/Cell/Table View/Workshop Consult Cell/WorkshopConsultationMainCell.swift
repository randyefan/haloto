//
//  WorkshopConsultationMainCell.swift
//  Haloto
//
//  Created by darindra.khadifa on 05/11/21.
//

import AsyncDisplayKit

internal final class WorkshopConsultationMainCell: ASCellNode {
    private let cardNode: WorkshopConsultationMainNode
    
    var delegate: ConsultViewController?

    override init() {
        cardNode = WorkshopConsultationMainNode()
        cardNode.style.width = ASDimensionMakeWithFraction(1)
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layout() {
        cardNode.delegate = delegate
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16), child: cardNode)
    }
}
