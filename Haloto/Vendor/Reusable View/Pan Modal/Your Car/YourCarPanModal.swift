//
//  YourCarPanModal.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/8/21.
//

import AsyncDisplayKit
import UIKit

class YouCarPanModal: ASDKViewController<ASDisplayNode> {
    // MARK: - Components

    private let chevronDown: ASImageNode = {
        let node = ASImageNode()
        node.image = UIImage.chevronDown
        node.style.preferredSize = CGSize(width: 36, height: 16)
        node.contentMode = .scaleAspectFit
        return node
    }()

    private let titleNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font(
            "Your Car",
            size: 24,
            fontWeight: .bold,
            alignment: .center,
            isTitle: true
        )
        return node
    }()

//    private var vehicleCardNode: VehicleCellNode
    private let promptNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font(
            "Is this correct?",
            size: 12,
            alignment: .center
        )
        return node
    }()

    private var reviewButton: SmallButtonNode?
    private var yesButton: SmallButtonNode?

    // MARK: - Variables

    private let vehicle: Vehicle

    init(vehicle: Vehicle) {
        self.vehicle = vehicle
//        vehicleCardNode = VehicleCellNode(model: vehicle)
        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        setAction()
        reviewButton?.style.width = ASDimension(unit: .fraction, value: 0.5)
        yesButton?.style.width = ASDimension(unit: .fraction, value: 0.5)

        node.layoutSpecBlock = { _, _ in
            let yourCarStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .center,
                alignItems: .center,
                children: [self.chevronDown, self.titleNode]
            )

            let buttonStack = ASStackLayoutSpec(
                direction: .horizontal,
                spacing: 8,
                justifyContent: .start,
                alignItems: .start,
                children: [self.reviewButton, self.yesButton].compactMap { $0 }
            )
            buttonStack.style.width = ASDimension(unit: .fraction, value: 1)

            let promptStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16,
                justifyContent: .center,
                alignItems: .center,
                children: [self.promptNode, buttonStack]
            )
            promptStack.style.width = ASDimension(unit: .fraction, value: 1)

            let viewStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 32,
                justifyContent: .center,
                alignItems: .center,
                children: [yourCarStack, promptStack]
            )

            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: .bottomSafeArea, right: 16), child: viewStack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Function Action Handler
    
    private func setAction(){
        chevronDown.view.onTap {
            self.dismiss(animated: true, completion: nil)
        }
        reviewButton = SmallButtonNode(title: "Review", buttonState: .GreyButton, function: {
            self.dismiss(animated: true, completion: nil)
        })
        yesButton = SmallButtonNode(title: "Yes", buttonState: .Yellow, function: {
            // TODO: Yes Action here
            print("Yes Action")
        })
    }

    override func viewDidLoad() {
        node.backgroundColor = .white
    }
}
