//
//  ProfileBackgroundCard.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import Alamofire
import AsyncDisplayKit
import Foundation

class ProfileBackgroundCard: ASDisplayNode {
    private let backgroundCard: ASImageNode = {
        let node = ASImageNode()
        node.style.height = ASDimension(unit: .points, value: 132)
        node.cornerRadius = 15
        return node
    }()

    private let editButton: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 15, height: 15)
        node.style.flexShrink = 1
        return node
    }()

    override init() {
        editButton.image = UIImage.editImage
        backgroundCard.image = UIImage.backgroundProfile
        backgroundCard.contentMode = .scaleToFill
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let editButtonInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 13,
                                 left: .infinity,
                                 bottom: .infinity,
                                 right: 13),
            child: editButton
        )

        return ASOverlayLayoutSpec(child: backgroundCard, overlay: editButtonInset)
    }
}
