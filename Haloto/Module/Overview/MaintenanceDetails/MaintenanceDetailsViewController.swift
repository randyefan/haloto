//
//  MaintenanceDetailsViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 09/11/21.
//

import AsyncDisplayKit

class MaintenanceDetailsViewController: ASDKViewController<ASDisplayNode>{
    
    let headerNode: PaymentReviewHeader = PaymentReviewHeader(title: "Maintenance Details")
    
    override init() {
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: .infinity, right: 0), child: self.headerNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}
