//
//  PaymentTimerNode.swift
//  Haloto
//
//  Created by Randy Efan Jayaputra on 07/11/21.
//

import Foundation
import AsyncDisplayKit

class PaymentTimerNode: ASDisplayNode {
    // MARK: - Variable Node
    
    let instructionPaymentNode: ASTextNode2
    let timerNode: ASTextNode2
    
    // MARK: - Variable
    
    var secondTimeout: Double = 0
    var timer: Timer?
    
    // MARK: - Initializer
    
    init(timeout: Double) {
        self.secondTimeout = timeout
        
        instructionPaymentNode = ASTextNode2()
        timerNode = ASTextNode2()
        
        instructionPaymentNode.attributedText = .font("Please finish the payment in :", size: 11, fontWeight: .medium, color: .blackApp, alignment: .center)
        
        super.init()
        style.width = ASDimension(unit: .fraction, value: 1)
        automaticallyManagesSubnodes = true
        
        timer = Timer(timeInterval: 1.0, target: self, selector: #selector(checkTimer), userInfo: nil, repeats: true)
                    
        if let timer = timer {
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
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
    
    // MARK: - Functionality
    
    func updateLabelCountTime() {
        timerNode.attributedText = .font("\(secondTimeout.stringFromTimeInterval(type: .short, isShowSecond: true, isSimplified: true))", size: 18, fontWeight: .bold, color: .blueApp, alignment: .center)
    }
    
    // MARK: - Layout Spec
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .vertical, spacing: 8, justifyContent: .center, alignItems: .center, children: [instructionPaymentNode, timerNode])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 16),
                                 child: stack)
    }
    
}
