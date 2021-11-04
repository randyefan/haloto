//
//  ProfileBackgroundCard.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import Alamofire
import AsyncDisplayKit
import Foundation
import RxSwift
import UIKit

protocol ProfileBackgroundCardDelegate {
    func didTapEdit()
}

class ProfileBackgroundCard: ASDisplayNode {
    
    //MARK: - Delegate
    var delegate: ProfileBackgroundCardDelegate?
    
    private let backgroundCard: ASImageNode = {
        let node = ASImageNode()
        node.style.height = ASDimension(unit: .points, value: 132)
        node.cornerRadius = 15
        return node
    }()

    private let editButton: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 16, height: 16)
        node.style.flexShrink = 1
        return node
    }()

    override init() {
        editButton.image = UIImage.editImage
        backgroundCard.image = UIImage.backgroundProfile
        backgroundCard.contentMode = .scaleToFill
        super.init()
        editButton.view.onTap {
            self.delegate?.didTapEdit()
        }
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let editButtonInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 12,
                                 left: .infinity,
                                 bottom: .infinity,
                                 right: 12),
            child: editButton
        )
        return ASOverlayLayoutSpec(child: backgroundCard, overlay: editButtonInset)
    }
}
