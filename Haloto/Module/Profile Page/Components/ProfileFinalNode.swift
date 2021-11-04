//
//  ProfileFinalNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import AsyncDisplayKit
import Foundation
import SwiftUI

class ProfileFinalNode: ASDisplayNode {
    
    // MARK: - Variables

    private let profileInfo: ProfileInfoNode
    private let ProfileBackground = ProfileBackgroundCard()
    private let RootView: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.height = ASDimension(unit: .points, value: 176)
        return node
    }()

    // MARK: - Init (Required)

    init(profile: Profile, delegate: ProfileBackgroundCardDelegate?) {
        ProfileBackground.delegate = delegate
        profileInfo = ProfileInfoNode(profile: profile)
        super.init()
        automaticallyManagesSubnodes = true
    }

    // MARK: - layoutSpecThatFits

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let profileBackgoundInset = ASInsetLayoutSpec(insets: UIEdgeInsets(
            top: .infinity,
            left: 0,
            bottom: 0,
            right: 0
        ),
        child: ProfileBackground)
        let profileBackgroundOverlay = ASOverlayLayoutSpec(child: RootView, overlay: profileBackgoundInset)
        let profileInfoInset = ASInsetLayoutSpec(insets: UIEdgeInsets(
            top: 0,
            left: .infinity,
            bottom: .infinity,
            right: .infinity
        ),
        child: profileInfo)
        return ASOverlayLayoutSpec(child: profileBackgroundOverlay, overlay: profileInfoInset)
    }
}
