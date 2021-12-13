//
//  HoldFeaturePopup.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 06/12/21.
//

import AsyncDisplayKit
import CoreGraphics

class HoldFeaturePopup: ASDisplayNode {
    
    private let popupNode: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 359, height: 424)
        node.image = UIImage(named: "Upcoming Summary Pop Up")
        return node
    }()
    
    override init() {
        super.init()
        setupUI()
    }
    
    func setupUI(){
        automaticallyManagesSubnodes = true
        style.preferredSize = CGSize(width: 359, height: 424)
        cornerRadius = 27
        clipsToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 0
        shadowRadius = 3
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: popupNode)
    }
}
