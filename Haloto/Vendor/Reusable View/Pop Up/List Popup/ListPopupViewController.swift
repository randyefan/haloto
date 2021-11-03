//
//  SearchListPopupViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 02/11/21.
//

import UIKit
import AsyncDisplayKit

enum PopUpListState: String {
    case model = "Model"
    case manufacturer = "Manufacturer"
    case service = "Service"
    case replaced = "Replaced"
}

class ListPopupViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Variable
    let listNode: ListPopUpNode
    
    // MARK: - Initializer
    init(state: PopUpListState) {
        listNode = ListPopUpNode(state: state)
        
        super.init(node: ASDisplayNode())
        node.backgroundColor = .white
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { _, _ in
            return ASWrapperLayoutSpec(layoutElement: self.listNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}
