//
//  ScrollNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 11/11/21.
//

import AsyncDisplayKit

class ScrollNode: ASScrollNode {
    let model = sampleMaintenanHistory
    let scanImageCard: ReceiptImageCard
    let textFieldMaintenance: TextFieldMaintenanceDetails
    let servicedTableNode: ServicedTableNode
    let detailSelectMaintenanceHistory: DetailSelectMaintenanceHistory
    let buttonAdd: SmallButtonNode
    
    override init() {
        scanImageCard = ReceiptImageCard(model: model[1], state: .beforeScan, function: { print("Scan Button Tapped")})
        textFieldMaintenance = TextFieldMaintenanceDetails()
        servicedTableNode = ServicedTableNode()
        detailSelectMaintenanceHistory = DetailSelectMaintenanceHistory()
        buttonAdd = SmallButtonNode(title: "+ Add New", buttonState: .BlueOutlined, function: {print("Button Add New Pressed")})
        buttonAdd.style.width = ASDimensionMake(358)
        buttonAdd.style.height = ASDimensionMake(44)
        super.init()
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
//        view.isScrollEnabled = true
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let cardInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: self.scanImageCard)
        
        let buttonInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: .infinity, bottom: 0, right: .infinity), child: buttonAdd)
        
        let serviceTableNodeInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: servicedTableNode)
        
        let contentStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .start, children: [cardInset, self.textFieldMaintenance, serviceTableNodeInset, buttonInset])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: contentStack)
    }
}
