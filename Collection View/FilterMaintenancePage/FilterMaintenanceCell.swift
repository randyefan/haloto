//
//  FilterMaintenanceCell.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 04/11/21.
//

import AsyncDisplayKit
import UIKit

class FilterMaintenanceCell: ASCellNode {
    private let filterName: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()

    private let backgroundFilter: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 84, height: 26)
        node.cornerRadius = 13
        node.backgroundColor = UIColor.backgroundUpcomingMaintenanceCell
        return node
    }()

    var buttonDeleteMaintenance: ButtonDeleteFilterMaintenance!

    init(model: Component) {
        filterName.attributedText = .font(
            model.name,
            size: 11,
            fontWeight: .medium,
            color: UIColor.white,
            alignment: .center
        )
        super.init()
        buttonDeleteMaintenance = ButtonDeleteFilterMaintenance(target: self, function: #selector(delete))
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10),
            child: filterName
        )

        let overlayFilter = ASOverlayLayoutSpec(child: backgroundFilter, overlay: inset)

        let insetFilter = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 8, left: 10, bottom: 10, right: 10),
            child: overlayFilter
        )

        let buttonDeleteInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: .infinity, bottom: .infinity, right: 12),
            child: buttonDeleteMaintenance
        )

        return ASOverlayLayoutSpec(
            child: insetFilter,
            overlay: buttonDeleteInset
        )
    }

    @objc func delete() {}
}
