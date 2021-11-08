//
//  PriceDetailsNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import Foundation
import AsyncDisplayKit

class PriceDetailsNode: ASDisplayNode {
    
    // MARK: - Variable Node
    
    let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Price Details", size: 18, fontWeight: .bold, color: .black, alignment: .left, isTitle: true)
        return node
    }()
    
    let maintenanceFeeTitle: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Maintenance fee", size: 12, fontWeight: .regular, color: .black, alignment: .left)
        return node
    }()
    
    let taxTitleNode: ASTextNode2?
    
    let lineNode: ASDisplayNode = {
        let node = ASTextNode2()
        node.style.height = ASDimension(unit: .points, value: 1)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        node.backgroundColor = UIColor(hexString: "#BEBEBE")
        return node
    }()
    
    let lineDashNode: ASDisplayNode = {
        let node = ASTextNode2()
        node.style.height = ASDimension(unit: .points, value: 1)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        return node
    }()
    
    let totalTitleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Total", size: 12, fontWeight: .regular, color: .black, alignment: .left)
        return node
    }()
    
    let maintenanceFeeNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    let taxNode: ASTextNode2?
    
    let totalNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    // MARK: - Initializer
    
    override init() {
        // Handle Later to check if there is a tax
        taxNode = ASTextNode2()
        taxNode?.attributedText = .font("Rp. 1.500,00", size: 12, fontWeight: .regular, color: .black, alignment: .right)
        taxTitleNode = ASTextNode2()
        taxTitleNode?.attributedText = .font("Tax 10%", size: 12, fontWeight: .regular, color: .black, alignment: .left)
        
        super.init()
        style.width = ASDimension(unit: .fraction, value: 1)
        automaticallyManagesSubnodes = true
        
        maintenanceFeeNode.attributedText = .font("Rp. 15.000,00", size: 12, fontWeight: .regular, color: .black, alignment: .right)
        totalNode.attributedText = .font("Rp. 16.500,00", size: 12, fontWeight: .regular, color: .black, alignment: .right)
    }
    
    // MARK: - Layout Spec
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        var taxStack: ASStackLayoutSpec?
        
        let maintenanceFeeStack = ASStackLayoutSpec(direction: .horizontal,
                                                    spacing: 0,
                                                    justifyContent: .spaceBetween,
                                                    alignItems: .stretch,
                                                    children: [maintenanceFeeTitle, maintenanceFeeNode])
        maintenanceFeeStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        if let taxNode = taxNode, let taxTitleNode = taxTitleNode {
            taxStack = ASStackLayoutSpec(direction: .horizontal,
                                         spacing: 0,
                                         justifyContent: .spaceBetween,
                                         alignItems: .stretch,
                                         children: [taxTitleNode, taxNode])
            taxStack?.style.width = ASDimension(unit: .fraction, value: 1)
        }
        
        let totalFeeStack = ASStackLayoutSpec(direction: .horizontal,
                                              spacing: 0,
                                              justifyContent: .spaceBetween,
                                              alignItems: .stretch,
                                              children: [totalTitleNode, totalNode])
        totalFeeStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let priceStack = ASStackLayoutSpec(direction: .vertical,
                                           spacing: 8,
                                           justifyContent: .start,
                                           alignItems: .start,
                                           children: [maintenanceFeeStack, taxStack, lineNode, totalFeeStack].compactMap({ $0 }))
        priceStack.style.width = ASDimension(unit: .fraction, value: 1)
        
        let priceStackWithDashLine = ASStackLayoutSpec(direction: .vertical,
                                                       spacing: 10,
                                                       justifyContent: .start,
                                                       alignItems: .start,
                                                       children: [priceStack, lineDashNode].compactMap({ $0 }))
        priceStackWithDashLine.style.width = ASDimension(unit: .fraction, value: 1)
        
        let stack = ASStackLayoutSpec(direction: .vertical,
                                 spacing: 8,
                                 justifyContent: .start,
                                 alignItems: .start,
                                 children: [titleNode, priceStackWithDashLine])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
                                 child: stack)
    }
    
    // MARK: - Layout func
    
    override func layout() {
        setDashLine()
    }
    
    // MARK: - Functionality
    
    private func setDashLine() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hexString: "#BEBEBE").cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: lineDashNode.bounds.minX, y: lineDashNode.bounds.minY), CGPoint(x: lineDashNode.bounds.maxX, y: lineDashNode.bounds.minY)])
        shapeLayer.path = path
        lineDashNode.layer.addSublayer(shapeLayer)
    }
}
