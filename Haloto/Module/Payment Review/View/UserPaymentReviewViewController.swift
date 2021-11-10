//
//  UserPaymentReviewViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import UIKit
import AsyncDisplayKit

class UserPaymentReviewViewController: ASDKViewController<ASDisplayNode> {
    let headerNode: PaymentReviewHeader = PaymentReviewHeader(title: "Payment Page")
    let workshopCard: WorkshopConsultationCard
    let paymentTimerNode: PaymentTimerNode
    let priceDetailNode: PriceDetailsNode
    let paymentMethodeNode: PaymentMethodNode
    let paymentTotalNode: PaymentTotalNode
    
    override init() {
        // Handle later with data
        workshopCard = WorkshopConsultationCard()
        paymentTimerNode = PaymentTimerNode(timeout: 6000)
        priceDetailNode = PriceDetailsNode()
        paymentMethodeNode = PaymentMethodNode()
        paymentTotalNode = PaymentTotalNode()
        
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        
        tapObserve()
        
        node.layoutSpecBlock = { _, _ in
            let workshopCardInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8),
                                                      child: self.workshopCard)
            
            let contentStack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .start, alignItems: .stretch, children: [workshopCardInset, self.paymentTimerNode, self.priceDetailNode, self.paymentMethodeNode])
            
            let paymentTotalInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .infinity, left: 16, bottom: 16, right: 16),
                                                      child: self.paymentTotalNode)
            
            let overlayBottom = ASOverlayLayoutSpec(
                child: contentStack,
                overlay: paymentTotalInset
            )
            
            let bottomInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea + 48 + 12, left: 0, bottom: .bottomSafeArea, right: 0), child: overlayBottom)
            
            let headerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: .infinity, right: 0), child: self.headerNode)
            
            return ASOverlayLayoutSpec(child: bottomInset, overlay: headerInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.hideTabBar()
        node.backgroundColor = .white
    }
    
    // MARK: - Functionality
    
    func showPopUpRequestConsult() {
        let vc = ReusableConsultPopUpViewController(state: .request)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: {
            self.navigationController?.popViewController(animated: false)
        })
    }
    
    // MARK: - Observe Tap
    
    func tapObserve() {
        headerNode.xAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        paymentTotalNode.confirmAction = {
            self.showPopUpRequestConsult()
        }
    }
}
