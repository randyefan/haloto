//
//  ReceiptImageCard.swift
//  Haloto
//
//  Created by Dheo Gildas Varian on 10/11/21.
//

import AsyncDisplayKit

class ReceiptImageCard: ASDisplayNode {
    let receiptImage: ASImageNode = {
        let node = ASImageNode()
        node.style.preferredSize = CGSize(width: 358, height: 70)
        node.cornerRadius = 15
        return node
    }()

    private let textAfterScan: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("View Image", size: 12, fontWeight: .regular)
        return node
    }()

    init(model: MaintenanceHistory, state: ReceiptCardImage, function: (() -> Void)?) {
        switch state {
        case .beforeScan:
            receiptImage.image = UIImage(named: "ScanReceiptImage")
            textAfterScan.isHidden = true
            receiptImage.view.onTap(action: function)
        case .afterScan:
            receiptImage.image = UIImage(named: "\(model.maintenanceHistoryImage ?? "")")
            receiptImage.view.onTap(action: function)
        }
        super.init()
        automaticallyManagesSubnodes = true
    }

    override func layoutSpecThatFits(_: ASSizeRange) -> ASLayoutSpec {
        let textInset = ASInsetLayoutSpec(
            insets: UIEdgeInsets(
                top: .infinity,
                left: .infinity,
                bottom: .infinity,
                right: .infinity
            ),
            child: textAfterScan
        )

        return ASOverlayLayoutSpec(child: receiptImage, overlay: textInset)
    }
}
