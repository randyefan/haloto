//
//  ContentConsultPopupNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 06/11/21.
//

import Foundation
import AsyncDisplayKit

class ContentConsultPopupNode: ASDisplayNode {
    
    // MARK: - Node Variable
    
    private let workshopCardNode: WorkshopConsultationCard = {
        let node = WorkshopConsultationCard()
        node.style.height = ASDimensionMake(133)
        node.style.width = ASDimension(unit: .fraction, value: 1)
        return node
    }()
    
    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        return node
    }()
    
    private let illustrationNode: ASImageNode = {
        let node = ASImageNode()
        node.style.maxHeight = ASDimension(unit: .points, value: 293)
        node.style.flexGrow = 1
        return node
    }()
    
    private var captionNode: ASTextNode2?
    private var buttonNode: SmallButtonNode?
    private var timerNode: ASTextNode2?
    
    // MARK: - Variable
    
    var secondTimeout: Double = 0
    var popUpState: ReusableConsultPopUpState
    var timer: Timer?
    
    // MARK: - Initializer
    
    init(state: ReusableConsultPopUpState, secondTimeout: Double = 0) {
        self.secondTimeout = secondTimeout
        self.popUpState = state
        
        super.init()
        
        switch state {
        case .request:
            titleNode.attributedText = .font(
                "Request Sent!",
                size: 18,
                fontWeight: .bold,
                color: .black,
                alignment: .center,
                isTitle: true)
            
            illustrationNode.image = UIImage(named: "x_icon_bg")
            
            captionNode = ASTextNode2()
            captionNode?.attributedText = .font(
                "Your consultation request have been sent to the workshop\nPlease wait for the workshop to accept the request",
                size: 12,
                color: .black,
                lineSpacing: 0,
                alignment: .center)
            
            timerNode = ASTextNode2()
            
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)
            
            if let timer = timer {
                RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            }

        case .accepted:
            titleNode.attributedText = .font(
                "You are ready to chat!",
                size: 18,
                fontWeight: .bold,
                color: .black,
                alignment: .center,
                isTitle: true)
            
            illustrationNode.image = UIImage(named: "x_icon_bg")
            
            captionNode = ASTextNode2()
            captionNode?.attributedText = .font(
                "Payment for consultation have been confirmed Start consultation now",
                size: 12,
                color: .black,
                lineSpacing: 0,
                alignment: .center)
            
            buttonNode = SmallButtonNode(title: "Consult", buttonState: .Yellow, function: nil)
            buttonNode?.style.width = ASDimension(unit: .points, value: 118)
            
        case .declined:
            titleNode.attributedText = .font(
                "Hey, Sorry...",
                size: 18,
                fontWeight: .bold,
                color: .black,
                alignment: .center,
                isTitle: true)
            
            illustrationNode.image = UIImage(named: "x_icon_bg")
            
            captionNode = ASTextNode2()
            captionNode?.attributedText = .font(
                "Unfortunately your chosen workshop was handling  issues elsewhere and couldn’t connect to you. Find  other workshops to connect instead!",
                size: 12,
                color: .black,
                lineSpacing: 0,
                alignment: .center)
            
            buttonNode = SmallButtonNode(title: "Take Me Home", buttonState: .Yellow, function: nil)
            buttonNode?.style.width = ASDimension(unit: .points, value: 126)
            
        case .afterService:
            titleNode.attributedText = .font(
                "Tell Us Your Experience?",
                size: 18,
                fontWeight: .bold,
                color: .black,
                alignment: .center,
                isTitle: true)
            
            illustrationNode.image = UIImage(named: "x_icon_bg")
            
            buttonNode = SmallButtonNode(title: "Give Review", buttonState: .Yellow, function: nil)
            buttonNode?.style.width = ASDimension(unit: .points, value: 118)
        }
        
        automaticallyManagesSubnodes = true
    }
    
    // MARK: - Node Layout
    
    override func layout() {
        super.layout()
        backgroundColor = .white
        setShadow()
    }
    
    // MARK: - Functionality
    
    private func setShadow() {
        clipsToBounds = false
        shadowColor = UIColor.black.cgColor
        shadowOpacity = 0.12
        shadowOffset.height = 2
        shadowRadius = 4
        cornerRadius = 15
    }
    
    private func updateLabelCountTime() {
        timerNode?.attributedText = .font("\(secondTimeout.stringFromTimeInterval(type: .short, isShowSecond: true, isSimplified: true))",
                                          size: 12,
                                          color: UIColor(hexString: "#A6A6A6"),
                                          alignment: .center)
    }
    
    // MARK: - Selector function (just for Timer)
    
    @objc func checkTimer() {
        secondTimeout -= 0
        
        if secondTimeout != 0 {
            secondTimeout -= 1
            updateLabelCountTime()
            setNeedsLayout()
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    // MARK: - Layout spec
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let imageInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: illustrationNode)
        
        var captionInset: ASInsetLayoutSpec?
        
        if let captionNode = captionNode {
            captionInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30), child: captionNode)
        }
        
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 16, justifyContent: .end, alignItems: .center, children: [titleNode, imageInset, captionInset, buttonNode, timerNode].compactMap { $0 })
        
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18), child: stack)
        
        if popUpState == .declined {
            return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [inset])
        }
        
        return ASStackLayoutSpec(direction: .vertical, spacing: 0, justifyContent: .start, alignItems: .stretch, children: [workshopCardNode ,inset])
    }
}
