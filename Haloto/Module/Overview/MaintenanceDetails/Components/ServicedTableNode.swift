//
//  ServicedTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class ServicedTableNode: ASDisplayNode {
    let model = sampleComponentList
    
    let servicedTableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        servicedTableNode.dataSource = self
        servicedTableNode.delegate = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: servicedTableNode)
    }
}

extension ServicedTableNode: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let data = model[indexPath.row]
        return SelectedComponentCell(model: data)
    }
}
