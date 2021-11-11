//
//  PaymentTotalNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import Foundation
import AsyncDisplayKit

class PaymentTotalNode: ASDisplayNode {
    // MARK: - Variable Node
    
    let totalTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Total", size: 14, fontWeight: .regular, color: .black, alignment: .left)
        return node
    }()
    
    let totalNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    let buttonTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("PAY & CONFIRM", size: 18, fontWeight: .bold, color: .black, alignment: .center)
        return node
    }()
    
    let buttonBackgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimension(unit: .points, value: 58)
        node.backgroundColor = UIColor(hexString: "#FFC940")
        return node
    }()
    
    var confirmAction: (()->())?
    
    // MARK: - Initializer
    
    override init() {
        // Handle Later with data
        totalNode.attributedText = .font("Rp. 16.500,00", size: 18, fontWeight: .bold, color: .black, alignment: .right)
        
        super.init()
        automaticallyManagesSubnodes = true
        style.height = ASDimension(unit: .points, value: 156)
    }
    
    // MARK: - Layout Spec
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [totalTitleNode, totalNode])
        topStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let titleInset = ASInsetLayoutSpec(insets: UIEdgeInsets(
            top: .infinity,
            left: .infinity,
            bottom: .infinity,
            right: .infinity
        ),
        child: buttonTitleNode)
        
        let overlayButton = ASOverlayLayoutSpec(child: buttonBackgroundNode, overlay: titleInset)
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 32, justifyContent: .start, alignItems: .start, children: [topStack, overlayButton])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 23, left: 26, bottom: 16, right: 26),
                                 child: stack)
    }
    
    // MARK: - Layout
    
    override func layout() {
        setShadow()
        
        buttonTitleNode.view.onTap {
            self.confirmAction?()
        }
    }
    
    // MARK: - Functionality
    
    func setShadow() {
        backgroundColor = .white
        clipsToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
        cornerRadius = 15
        
        buttonBackgroundNode.cornerRadius = 58 / 2
    }
}
