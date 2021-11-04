//
//  CellSelectedListPopUpNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 03/11/21.
//

import Foundation
import AsyncDisplayKit
import UIKit

class CellSelectedListPopUpNode: ASCellNode {
    // MARK: - Variable
    private let titleNode: ASTextNode2
    
    private let imageRemoveNode: ASImageNode = {
        let image = ASImageNode()
        image.style.preferredSize = CGSize(width: 16, height: 16)
        image.image = UIImage(named: "x_icon_bg")
        return image
    }()
    
    init(title: String) {
        titleNode = ASTextNode2()
        titleNode.attributedText = .font("\(title)", size: 11, fontWeight: .medium, color: .white, alignment: .center, underline: false, isTitle: false)
        
        super.init()
        automaticallyManagesSubnodes = true
        titleNode.backgroundColor = .blueApp
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASCornerLayoutSpec(child: titleNode, corner: imageRemoveNode, location: .topRight)
    }
}
