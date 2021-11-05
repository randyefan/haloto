//
//  OverviewViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 05/11/21.
//

import UIKit
import AsyncDisplayKit

class OverviewViewController: ASDKViewController<ASDisplayNode> {
    let modelVehicle = sampleVehicle
    private let collectionNode: ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let node = ASCollectionNode(collectionViewLayout: flowLayout)
        node.style.width = ASDimensionMakeWithFraction(1)
        node.style.height = ASDimensionMake(280)
        return node
    }()
    
    // MARK: - Initializer (Required)
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { [weak self] _, _ in
            guard let self = self else { return ASLayoutSpec() }
            return ASInsetLayoutSpec(
                insets: UIEdgeInsets(top: 0, left: 0, bottom: .infinity, right: 0),
                child: self.collectionNode
            )
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .blue
        collectionNode.delegate = self
        collectionNode.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
    }
}

extension OverviewViewController: ASCollectionDelegate, ASCollectionDataSource{
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        modelVehicle.count
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        let data = modelVehicle[indexPath.row]
        return VehicleCellNode(model: data)
    }
    
}
