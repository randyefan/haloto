//
//  UserPaymentReviewViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import UIKit
import AsyncDisplayKit

class UserPaymentReviewViewController: ASDKViewController<ASDisplayNode> {
    let paymentTimerNode: PaymentTimerNode
    let priceDetailNode: PriceDetailsNode
    let paymentMethodeNode: PaymentMethodNode
    let paymentTotalNode: PaymentTotalNode
    
    override init() {
        // Handle later with data
        paymentTimerNode = PaymentTimerNode(timeout: 58000)
        priceDetailNode = PriceDetailsNode()
        paymentMethodeNode = PaymentMethodNode()
        paymentTotalNode = PaymentTotalNode()
        
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        
        node.layoutSpecBlock = { _, _ in
            let contentStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .start, children: [self.paymentTimerNode, self.priceDetailNode, self.paymentMethodeNode])
            
            let paymentTotalInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: 16, right: 16),
                                                      child: self.paymentTotalNode)
            
            return ASOverlayLayoutSpec(
                child: contentStack,
                overlay: paymentTotalInset
            )
        }
    }œ
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            // Always adopt a light interface style.
            overrideUserInterfaceStyle = .light
        }
    }

}

#if DEBUG
import SwiftUI

@available(iOS 13, *)
struct InfoVCPreview: PreviewProvider {
    static var previews: some View {
        UserPaymentReviewViewController().toPreview()
    }
}
#endif
