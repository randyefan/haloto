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
    let scanImageCard: ReceiptImageCard
    let textFieldMaintenance: TextFieldMaintenanceDetails

    override init() {
        scanImageCard = ReceiptImageCard(model: model[1], state: .beforeScan, function: { print("Scan Button Tapped")})
        textFieldMaintenance = TextFieldMaintenanceDetails()
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.layoutSpecBlock = { _, _ in
            let headerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: .infinity, right: 0), child: self.headerNode)
            let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: self.scanImageCard)
            let stack = ASStackLayoutSpec(direction: .vertical, spacing: 6, justifyContent: .start, alignItems: .start, children: [inset, self.textFieldMaintenance])
            let bottomInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea + 48 + 12, left: 0, bottom: .bottomSafeArea, right: 0), child: stack)

            return ASOverlayLayoutSpec(child: bottomInset, overlay: headerInset)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }
}
