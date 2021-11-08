//
//  PaymentMethodNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import Foundation
import AsyncDisplayKit
import UIKit

class PaymentMethodNode: ASDisplayNode {
    
    // MARK: - Variable Node
    
    let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Payment Method", size: 18, fontWeight: .bold, color: .black, alignment: .left, isTitle: true)
        return node
    }()
    
    let captionNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Please transfer to the following account", size: 11, fontWeight: .medium, color: UIColor(hexString: "#C4C4C4"), alignment: .left)
        return node
    }()
    
    let copyBackgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = UIColor.blueApp
        node.style.height = ASDimension(unit: .points, value: 26)
        node.style.width = ASDimension(unit: .points, value: 62)
        return node
    }()
    
    let copyTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Copy", size: 11, fontWeight: .medium, color: .white, alignment: .center)
        return node
    }()
    
    let accoundBackgroundNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.backgroundColor = .white
        node.style.height = ASDimension(unit: .points, value: 63)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        return node
    }()
    
    let titleAccountNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    let captionAccountNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    // MARK: - Initializer
    override init() {
        // Handle Later with data
        titleAccountNode.attributedText = .font("BCA - 1234567890", size: 18, fontWeight: .bold, color: .black, alignment: .left)
        captionAccountNode.attributedText = .font("a/n Bengkel Harapan", size: 12, fontWeight: .regular, color: .black, alignment: .left)
        
        super.init()
        style.width = ASDimension(unit: .fraction, value: 1)
        automaticallyManagesSubnodes = true
    }
    
    // MARK: - Layout spec
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let titleStack = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [titleNode, captionNode])
        
        let copyTitleInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(
                top: .infinity,
                left: .infinity,
                bottom: .infinity,
                right: .infinity),
            child: copyTitleNode)
        
        let copyNode = ASOverlayLayoutSpec(child: copyBackgroundNode, overlay: copyTitleInset)
        
        let titleAccountStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [titleAccountNode, copyNode])
        titleAccountStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let accountNumberStack = ASStackLayoutSpec(direction: .vertical, spacing: 4, justifyContent: .start, alignItems: .start, children: [titleAccountStack, captionAccountNode])
        titleAccountStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let accountInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                                             child: accountNumberStack)
        accountInset.style.width = ASDimension(unit: .fraction, value: 1)
        
        let accountBackground = ASOverlayLayoutSpec(child: accoundBackgroundNode, overlay: accountInset)
        accountBackground.style.width = ASDimension(unit: .fraction, value: 1)
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .start, children: [titleStack, accountBackground])
        stack.style.width = ASDimension(unit: .fraction, value: 1)
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
                                 child: stack)
    }
    
    // MARK: - Layout
    
    override func layout() {
        setShadow()
    }
    
    // MARK: - Functionality
    
    private func setShadow() {
        copyBackgroundNode.cornerRadius = 26 / 2
        
        accoundBackgroundNode.clipsToBounds = false
        accoundBackgroundNode.shadowColor = UIColor.black.cgColor
        accoundBackgroundNode.shadowOpacity = 0.12
        accoundBackgroundNode.shadowOffset.height = 2
        accoundBackgroundNode.shadowRadius = 4
        accoundBackgroundNode.cornerRadius = 6
    }
}
