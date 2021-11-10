//
//  TextFieldMaintenanceDetails.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit
import UIKit

class TextFieldMaintenanceDetails: ASDisplayNode {
    
    let titleTextField: TextField = TextField(title: "", placeholder: "Maintenance Title ex. Sudden Service", state: .Editable)
    let lineTitleNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "LineTextField")
        return node
    
    }()
    
    let dateTextField: TextField = TextField(title: "", placeholder: "Date", state: .Editable)
    let lineDateNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "LineTextField")
        return node
    
    }()
    private let dateButtonNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(systemName: "calendar")
        node.style.preferredSize = CGSize(width: 18, height: 17)
        return node
    }()
    
    let locationTextField: TextField = TextField(title: "", placeholder: "Location", state: .Editable)
    let lineLocationNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "LineTextField")
        return node
    
    }()
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let maintenanceTitleStack =  ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [titleTextField, lineTitleNode])
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 30), child: dateTextField)
        let iconInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: dateButtonNode)
        let dateAndIconStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [inset, iconInset])
        let maintenanceDateStack =  ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [dateAndIconStack, lineDateNode])
        
        let maintenanceLocationStack =  ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .start, children: [locationTextField, lineLocationNode])
        
        let finalStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .start, children: [maintenanceTitleStack, maintenanceDateStack, maintenanceLocationStack])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: maintenanceTitleStack)
    }
}




