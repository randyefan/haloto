//
//  MaintenanceDetailsViewController.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 09/11/21.
//

import AsyncDisplayKit

class MaintenanceDetailsViewController: ASDKViewController<ASDisplayNode> {
    let model = sampleMaintenanHistory
    let headerNode = PaymentReviewHeader(title: "Maintenance Details")
    let updateHistoryNode: UpdateHistoryNode
    let scrollNode: ScrollNode

    override init() {
        scrollNode = ScrollNode()
        updateHistoryNode = UpdateHistoryNode()
        scrollNode.style.flexShrink = 1

        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in

            let headerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: self.headerNode)

            let scrollNodeInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea + 48 + 12, left: 0, bottom: .bottomSafeArea + 76, right: 0), child: self.scrollNode)

            let updateHistoryInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: .bottomSafeArea, right: 0), child: self.updateHistoryNode)
            
            let headerBottomStack = ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .spaceBetween, alignItems: .start, children: [headerInset, updateHistoryInset])

            return ASOverlayLayoutSpec(child: scrollNodeInset, overlay: headerBottomStack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
    }
}
