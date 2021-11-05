//
//  EditProfilePictureNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/5/21.
//

import AsyncDisplayKit
import CoreGraphics
import SwiftUI
import UIKit

protocol EditProfilePictureNodeDelegate {
    func editProfilePictureAction()
}

class EditProfilePictureNode: ASDisplayNode {
    var delegate: EditProfilePictureNodeDelegate?

    private let profilePictureNode: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 96, height: 96)
        node.cornerRadius = 96 / 2
        return node
    }()

    private let overlayProfilePicture: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 96, height: 96)
        node.cornerRadius = 96 / 2
        node.backgroundColor = UIColor.black
        node.alpha = 0.6
        return node
    }()

    func updateImage(newImage: UIImage) {
        profilePictureNode.image = newImage
    }

    private let editButton: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 16, height: 16)
        node.image = UIImage.editImage.withTintColor(.white)
        return node
    }()

    init(profilePictureUrl: String) {
        let url = URL(string: profilePictureUrl)
        profilePictureNode.url = url
        super.init()
        overlayProfilePicture.view.onTap {
            self.delegate?.editProfilePictureAction()
        }
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let profilePictureDarken = ASOverlayLayoutSpec(child: profilePictureNode, overlay: overlayProfilePicture)
        let insetEditButton = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: .infinity,
                                 left: .infinity,
                                 bottom: .infinity,
                                 right: .infinity),
            child: editButton
        )
        return ASOverlayLayoutSpec(child: profilePictureDarken, overlay: insetEditButton)
    }
}
