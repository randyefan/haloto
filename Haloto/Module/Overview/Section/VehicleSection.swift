//
//  VehicleSection.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import AsyncDisplayKit

class VehicleSection: ASDisplayNode {
    let modelVehicle = sampleVehicle

    private let displayNode: ASDisplayNode = {
        let node = ASDisplayNode()
        node.style.preferredSize = CGSize(width: 358, height: 200)

        return node
    }()

    private let collectionNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal

        let node = ASCollectionNode(collectionViewLayout: flowLayout)
        node.style.width = ASDimensionMakeWithFraction(1)
        node.style.height = ASDimensionMake(100)
        return node
    }()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        collectionNode.delegate = self
        collectionNode.dataSource = self
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: displayNode)
        return ASOverlayLayoutSpec(child: inset, overlay: collectionNode)
        
    }
}

extension VehicleSection: ASCollectionDelegate, ASCollectionDataSource {
    func collectionNode(_: ASCollectionNode, numberOfItemsInSection _: Int) -> Int {
        modelVehicle.count
    }

    func collectionNode(_: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let data = modelVehicle[indexPath.row]
        return VehicleCellNode(model: data)
    }
}
