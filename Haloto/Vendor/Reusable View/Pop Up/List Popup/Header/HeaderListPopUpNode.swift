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
    private let imageBackNode: ASDisplayNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "x_icon")
        node.style.preferredSize = CGSize(width: 36, height: 36)
        return node
    }()

    private let titleNode: ASTextNode2 = {
        var node = ASTextNode2()
        node.style.flexGrow = 1
        return node
    }()

    private var yellowButton: SmallYellowButtonNode?
    private var blueOutlineButton: SmallOutlineButtonNode?

    // MARK: - Initializer
    init(state: PopUpListState) {
        titleNode.attributedText = .font(
            "\(state.rawValue)",
            size: 18,
            fontWeight: .bold,
            alignment: .center,
            isTitle: true
        )

        super.init()
        setupButton(state: state)
        automaticallyManagesSubnodes = true
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
        let stack = ASStackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .spaceBetween,
            alignItems: .center,
            children: [imageBackNode, yellowButton, blueOutlineButton].compactMap { $0 }
        )

        let centerTitle = ASCenterLayoutSpec(centeringOptions: .XY, sizingOptions: [], child: titleNode)
        let background = ASBackgroundLayoutSpec(child: stack, background: centerTitle)

        return background
//        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 0, bottom: 0, right: 0), child: stackHeader)
    }

    private func setupButton(state: PopUpListState) {
        switch state {
        case .model, .manufacturer:
            yellowButton = SmallYellowButtonNode(title: "Confirm", target: self, function: #selector(tapButtonRight))
            yellowButton?.style.height = ASDimensionMake(36)
            blueOutlineButton = nil
        default:
            blueOutlineButton = SmallOutlineButtonNode(title: "Add", target: self, function: #selector(tapButtonRight))
            blueOutlineButton?.style.height = ASDimensionMake(36)
            yellowButton = nil
        }

    }
}
