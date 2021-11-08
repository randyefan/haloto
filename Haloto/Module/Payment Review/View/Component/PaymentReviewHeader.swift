//
//  PaymentReviewHeader.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 08/11/21.
//

import Foundation
import AsyncDisplayKit

class PaymentReviewHeader: ASDisplayNode {
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Payment Page", size: 18, fontWeight: .bold, color: .black, alignment: .center)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        return node
    }()

    private let xButtonNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "x_icon")
        node.style.preferredSize = CGSize(width: 26, height: 26)
        return node
    }()
    
    override init() {
        super.init()
        style.height = ASDimension(unit: .points, value: .topSafeArea + 48)
        automaticallyManagesSubnodes = true
        setShadow()
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let xInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 26, bottom: 8, right: .infinity), child: xButtonNode)
        let titleInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 0, bottom: 8, right: 0), child: titleNode)
        
        return ASOverlayLayoutSpec(child: xInset, overlay: titleInset)
    }
    
    override func layout() {
        super.layout()
        backgroundColor = .white
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    func setShadow() {
        cornerRadius = 15
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
