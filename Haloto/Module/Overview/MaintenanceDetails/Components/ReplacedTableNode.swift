//
//  ReplacedTableNode.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 11/11/21.
//

import AsyncDisplayKit

class ReplacedTableNode: ASDisplayNode {
    
    let model = sampleComponentList
    
    let titleTable: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Replaced", size: 18, fontWeight: .bold, isTitle: true)
        return node
    }()
    
    let replacedTableNode: ASTableNode = {
        let node = ASTableNode()
        return node
    }()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        tableSetup()
    }
    
    func tableSetup() {
        replacedTableNode.dataSource = self
        replacedTableNode.delegate = self
        replacedTableNode.style.height = ASDimensionMake(50 * CGFloat(model.count + 1))
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(
            direction: .vertical,
            spacing: 8,
            justifyContent: .start,
            alignItems: .stretch,
            children: [titleTable, replacedTableNode]
        )
        
        return ASWrapperLayoutSpec(layoutElement: stack)
    }
}

extension ReplacedTableNode: ASTableDelegate, ASTableDataSource {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        model.count + 1
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if (indexPath.row == model.count) {
            return WrapperSelectNode(placeHolder: "Choose what part you replaced", function: {print("button replaced pressed")})
        }else {
            let data = model[indexPath.row]
            return SelectedComponentCell(model: data)
        }
    }
}

