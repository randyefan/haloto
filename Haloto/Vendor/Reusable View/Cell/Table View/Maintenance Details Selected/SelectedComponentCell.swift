//
//  SelectedComponentCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class SelectedComponentCell: ASCellNode {
    
    let nameText: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    let priceNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.style.alignSelf = .end
        return node
    }()
    
    init(model: ComponentList) {
        nameText.attributedText = .font(
            "\(model.componentListName ?? "")",
            size: 12,
            fontWeight: .regular
        )
        priceNode.attributedText = .font(
            "\(model.componentListName ?? "")",
            size: 12,
            fontWeight: .regular
        )
        super.init()
        automaticallyManagesSubnodes = true
        setShadow()
        setupCell()
    }
    
    func setupCell() {
        borderColor = UIColor.greyApp.cgColor
        style.height = ASDimensionMake(50)
        borderWidth = 0.5
    }
    
    func setShadow() {
        clipsToBounds = false
        cornerRadius = 6
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 8), child: priceNode)
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 0,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [nameText, inset])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: stack)
    }

}
