//
//  ProfileInfoNode.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

class ProfileInfoNode: ASDisplayNode {
    // MARK: - Components

    private let profilePicture: ASNetworkImageNode = {
        let node = ASNetworkImageNode()
        node.style.preferredSize = CGSize(width: 88, height: 88)
        node.cornerRadius = 88 / 2
        node.borderWidth = 4
        node.borderColor = UIColor.white.cgColor
        return node
    }()

    private let profileName: ASTextNode = {
        let node = ASTextNode()
        return node
    }()

    private let profileEmail: ASTextNode = {
        let node = ASTextNode()

        return node
    }()

    private let profilePhone: ASTextNode = {
        let node = ASTextNode()
        node.maximumNumberOfLines = 0
        return node
    }()

    // MARK: - Init (Required)

    init(profile: Profile) {
        profilePicture.image = UIImage(named: profile.profilePicture)

        profileName.attributedText = .font(
            profile.profileName,
            size: 16,
            fontWeight: .bold,
            color: .white,
            alignment: .center
        )

        let emailAttachment = NSTextAttachment()
        emailAttachment.image = UIImage.emailImage.withTintColor(UIColor.white)
        emailAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 16)
        profileEmail.attributedText = .fontWithAttachment(
            " \(profile.profileEmail)",
            size: 12, color: UIColor.white,
            alignment: .center,
            prefixAttachment: emailAttachment
        )

        let phoneAttachment = NSTextAttachment()
        phoneAttachment.image = UIImage.phoneImage.withTintColor(UIColor.white)
        phoneAttachment.bounds = CGRect(x: 0, y: -5, width: 20, height: 16)
        profilePhone.attributedText = .fontWithAttachment(
            " \(profile.profilePhone)",
            size: 12, color: UIColor.white,
            alignment: .center,
            prefixAttachment: phoneAttachment
        )
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layout() {
        super.layout()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    // MARK: - layoutSpecThatFits

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .vertical,
            spacing: 5,
            justifyContent: .center,
            alignItems: .center,
            children: [profilePicture, profileName, profileEmail, profilePhone]
        )
    }
}
