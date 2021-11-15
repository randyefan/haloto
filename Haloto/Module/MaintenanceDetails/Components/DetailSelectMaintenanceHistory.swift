//
//  ServicedMaintenanceHistory.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class DetailSelectMaintenanceHistory: ASDisplayNode {
    
    let servicedFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Serviced", placeholder: "Choose what part you serviced")
        return node
    }()
    
    let replacedFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Replaced", placeholder: "Choose what part you replaced")
        return node
    }()
    
    let otherFormNode: SelectFieldStack = {
        let node = SelectFieldStack(title: "Other", placeholder: "Other expenses")
        return node
    }()
    
    private lazy var odometerFormNode: FormFieldStack = {
        let node = FormFieldStack(isPicker: false, title: "Current Odometer", placeholder: "Current Km", keyboardType: .numberPad)
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .center, alignItems: .start, children: [servicedFormNode, replacedFormNode, odometerFormNode, otherFormNode])
        stack.style.width = ASDimensionMake("100%")
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: stack)
    }
    

}
