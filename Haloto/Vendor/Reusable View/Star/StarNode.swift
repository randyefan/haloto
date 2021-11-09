//
//  StarNode.swift
//  Haloto
//
//  Created by darindra.khadifa on 08/11/21.
//

import AsyncDisplayKit

internal final class StarNode: ASDisplayNode {

    private let star: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 47, height: 45)
        return node
    }()

    var rating: (() -> ())?

    init(_ state: StarState) {
        switch state {
        case .active:
            star.image = UIImage(named: "Rating Star Active")
        case .inactive:
            star.image = UIImage(named: "Rating Star Inactive")
        }

        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layout() {
        super.layout()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        view.addGestureRecognizer(gesture)
    }

    @objc private func didTap() {
        rating?()
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        ASWrapperLayoutSpec(layoutElement: star)
    }
}
