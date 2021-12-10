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

protocol HeaderListPopUpNodeDelegate {
    func didTapRight()
    func didTapLeft()
}

class HeaderListPopUpNode: ASDisplayNode {
    // MARK: - Variable
    private let imageBackNode: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage(named: "x_icon")
        node.style.preferredSize = CGSize(width: 36, height: 36)
        node.isUserInteractionEnabled = true
        return node
    }()

    private let titleNode: ASTextNode2 = {
        var node = ASTextNode2()
        node.style.flexGrow = 1
        return node
    }()

    private var yellowButton: SmallButtonNode?
    private var blueOutlineButton: SmallButtonNode?

    var delegate: HeaderListPopUpNodeDelegate?

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
        yellowButton = SmallButtonNode(title: "Confirm", function: {
            print("yellow tapped")
        })
        automaticallyManagesSubnodes = true
        setupButton(state: state)

    }

    override func didLoad() {
        super.didLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapButtonLeft))
        imageBackNode.view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Selector Function
    @objc func tapButtonRight() {
        delegate?.didTapRight()
    }

    @objc func tapButtonLeft() {
        delegate?.didTapLeft()
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
        return ASBackgroundLayoutSpec(child: stack, background: centerTitle)
    }

    private func setupButton(state: PopUpListState) {
        switch state {
        case .model, .manufacturer:
            yellowButton = SmallButtonNode(title: "Confirm", function: {
                print("yellow tapped")
            })
        default:
            blueOutlineButton = SmallButtonNode(title: "Add", buttonState: .BlueOutlined, function: {
                print("blueOutline tapped")
            })
            blueOutlineButton?.style.height = ASDimensionMake(36)
            blueOutlineButton = nil
        }

    }
}
