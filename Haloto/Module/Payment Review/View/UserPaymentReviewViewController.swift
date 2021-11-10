//
//  UserPaymentReviewViewController.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import UIKit
import AsyncDisplayKit
import FirebaseAuth
import FirebaseFirestore

class UserPaymentReviewViewController: ASDKViewController<ASDisplayNode> {
    let headerNode: PaymentReviewHeader = PaymentReviewHeader()
    let workshopCard: WorkshopConsultationCard
    let paymentTimerNode: PaymentTimerNode
    let priceDetailNode: PriceDetailsNode
    let paymentMethodeNode: PaymentMethodNode
    let paymentTotalNode: PaymentTotalNode
    
    var namaBengkel: String?
    
    // TODO: MIGRATION LATER (4 Var)
    private var channelListener: ListenerRegistration?
    private let database = Firestore.firestore()
    private var channelReference: CollectionReference {
        return database.collection("channels")
    }
    private var channel: Channel?
    
    override init() {
        // Handle later with data
        workshopCard = WorkshopConsultationCard()
        paymentTimerNode = PaymentTimerNode(timeout: 0)
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
    
    func showPopUpAcceptedConsult() {
        let vc = ReusableConsultPopUpViewController(state: .accepted)
        vc.modalPresentationStyle = .fullScreen
        vc.dismissAction = {
            self.createChannel()
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    // TODO: MIGRATION LATER
    private func navigateToChatViewController(channel: Channel) {
        if let user = Auth.auth().currentUser {
            let vc = ChatViewController(user: user, channel: channel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // TODO: MIGRATION LATER (3 Func Below)
    private func createChannel() {
        let channel = Channel(name: namaBengkel ?? "Bengkel")
        channelReference.addDocument(data: channel.representation) { error in
            if let error = error {
                print("Error saving channel: \(error.localizedDescription)")
            }
        }
        
        self.listener()
    }
    
    private func listener() {
        channelListener = channelReference.addSnapshotListener { [weak self] querySnapshot, error in
            guard let self = self else { return }
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            var object: [Channel] = []
            snapshot.documentChanges.forEach { change in
                guard let channel = Channel(document: change.document) else {
                    return
                }
                
                switch change.type {
                case .added:
                    object.append(channel)
                default:
                    break
                }
            }
            
            object.sort()
            
            if let channel = object.last {
                self.navigateToChatViewController(channel: channel)
            }
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange?) {
        guard let change = change else { return }
        
        guard let channel = Channel(document: change.document) else { return }
        
        switch change.type {
        case .added:
            self.channel = channel
            AppSettings.chatId = channel.id
            self.navigateToChatViewController(channel: channel)
        default:
            break
        }
    }
    
    // MARK: - Observe Tap
    
    func tapObserve() {
        headerNode.xAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        //TODO: MIGRATION LATER
        paymentTotalNode.confirmAction = {
            self.showPopUpAcceptedConsult()
        }
    }
}
