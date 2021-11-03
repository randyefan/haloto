//
//  HeaderListPopUpNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 02/11/21.
//

import Foundation
import AsyncDisplayKit
import RxSwift
import UIKit

class HeaderListPopUpNode: ASDisplayNode {
    // MARK: - Variable
    
    private let imageBack: ASDisplayNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "x_icon")
        return node
    }()
    
    private let title: ASTextNode2 = {
        var textNode = ASTextNode2()
        textNode.style.flexGrow = 1
        return textNode
    }()
    
    private var yellowButton: SmallYellowButtonNode?
    private var blueOutlineButton: SmallOutlineButtonNode?
    
    private let state: PopUpListState
    
    // MARK: - Initializer
    
    init(state: PopUpListState) {
        self.state = state
        
        title.attributedText = .font("\(state.rawValue)", size: 18, fontWeight: .bold, color: .black, alignment: .center, isTitle: true)
        
        super.init()
        
        automaticallyManagesSubnodes = true
        
        switch state {
        case .model:
            yellowButton = SmallYellowButtonNode(title: "Confirm", target: self, function: #selector(tapButtonRight))
        case .manufacturer:
            yellowButton = SmallYellowButtonNode(title: "Confirm", target: self, function: #selector(tapButtonRight))
        case .service:
            blueOutlineButton = SmallOutlineButtonNode(title: "Add", target: self, function: #selector(tapButtonRight))
        case .replaced:
            blueOutlineButton = SmallOutlineButtonNode(title: "Add", target: self, function: #selector(tapButtonRight))
        }
        
        imageBack.view.onTap {
            self.tapButtonLeft()
        }
    }
    
    // MARK: - Selector Function
    
    @objc func tapButtonRight() {
        print("tapped")
    }
    
    @objc func tapButtonLeft() {
        print("tapped")
    }
    
    
    // MARK: - Layout spec
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        if let yellowButton = yellowButton {
            yellowButton.style.height = ASDimension(unit: .points, value: 36)
        } else if let blueOutlineButton = blueOutlineButton {
            blueOutlineButton.style.height = ASDimension(unit: .points, value: 36)
        }
        
        imageBack.style.preferredSize = CGSize(width: 26, height: 26)
        
        let stackHeader = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [imageBack, title, yellowButton, blueOutlineButton].compactMap { $0 }
        )
            
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 0, bottom: 0, right: 0), child: stackHeader)
    }
}
