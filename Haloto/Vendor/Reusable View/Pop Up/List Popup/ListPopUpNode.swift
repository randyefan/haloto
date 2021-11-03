//
//  SearchListNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 02/11/21.
//

import Foundation
import AsyncDisplayKit
import SwiftUI

class ListPopUpNode: ASDisplayNode {
    // MARK: - Variable
    let header: HeaderListPopUpNode
    var search: ASEditableTextNode?
    let tableList: ASTableNode
    
    let state: PopUpListState
    
    init(state: PopUpListState) {
        self.state = state
        
        header = HeaderListPopUpNode(state: state)
        tableList = ASTableNode()
        
        super.init()
        
        switch state {
        case .model, .manufacturer:
            search = ASEditableTextNode()
            search?.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            search?.borderColor = UIColor.greyApp.cgColor
            search?.borderWidth = 1
            search?.cornerRadius = 3
            search?.attributedPlaceholderText = .font("Search", size: 12, fontWeight: .regular, color: .gray, alignment: .left, isTitle: false)
        case .service, .replaced:
            search = nil
        }
        
        automaticallyManagesSubnodes = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let topStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .stretch, children: [header, search].compactMap{ $0 })
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0,
                                                      left: 12,
                                                      bottom: 0,
                                                      right: 12), child: topStack)
    }
}
