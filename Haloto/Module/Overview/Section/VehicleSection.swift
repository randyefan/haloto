//
//  VehicleSection.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit

class VehicleSection: ASDisplayNode, ASCollectionDataSource {
    let modelVehicle = sampleVehicle

    private let displayNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 358, height: 200)
        return node
    }()

    private let collectionNode: ASPagerNode = {
        let node = ASPagerNode()
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let insetCollection = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16),
            child: collectionNode
        )
        let inset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0),
            child: displayNode
        )
        return ASOverlayLayoutSpec(child: inset, overlay: insetCollection)
    }
}

extension VehicleSection: ASPagerDelegate, ASPagerDataSource {
    func numberOfPages(in _: ASPagerNode) -> Int {
        modelVehicle.count
    }

    func pagerNode(_: ASPagerNode, nodeAt index: Int) -> ASCellNode {
        let data = modelVehicle[index]
        return VehicleCellNode(model: data)
    }
}
