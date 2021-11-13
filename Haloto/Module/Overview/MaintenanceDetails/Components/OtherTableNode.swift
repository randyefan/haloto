//
//  OtherTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 13/11/21.
//

import AsyncDisplayKit

class OtherTableNode: ASDisplayNode {
    
    let model = sampleComponentList
    
    let titleTable: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Others", size: 18, fontWeight: .bold, isTitle: true)
        return node
    }()
    
    let otherTableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        tableSetup()
    }
    
    func tableSetup() {
        otherTableNode.dataSource = self
        otherTableNode.delegate = self
        otherTableNode.style.height = ASDimensionMake(50 * CGFloat(model.count + 1))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTable, otherTableNode]
        )
        
        return ASWrapperLayoutSpec(layoutElement: stack)
    }
}

extension OtherTableNode: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        model.count + 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if (indexPath.row == model.count) {
            return WrapperTextfieldOther()
        }else {
            let data = model[indexPath.row]
            return SelectedComponentCell(model: data)
        }
    }
}
