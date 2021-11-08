//
//  UserProfileViewController.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import AsyncDisplayKit
import Foundation
import UIKit

class UserProfileViewController: ASDKViewController<ASDisplayNode> {
    // MARK: - Components

    private var profileInfo: ProfileFinalNode
    private let vehicleTextNode: ASTextNode2 = {
        let node = ASTextNode2()
        node.attributedText = .font("Your Vehicle", size: 18, fontWeight: .bold, color: .blueApp)
        return node
    }()

    private let vehicleTableNode: ASTableNode = {
        let node = ASTableNode()
        node.style.width = ASDimension(unit: .fraction, value: 1)
        node.style.flexGrow = 1
        node.backgroundColor = .white
        return node
    }()

    // MARK: - Variable

    private var profile: Profile
    private var vehicle: [Vehicle?]?

    // MARK: - Initializer (Required)

    override init() {
        profile = dataDummy().profile
        vehicle = [dataDummy().vehicle, dataDummy().vehicle, dataDummy().vehicle, dataDummy().vehicle]
        profileInfo = ProfileFinalNode(profile: profile)

        super.init(node: ASDisplayNode())
        node.automaticallyManagesSubnodes = true
        node.automaticallyRelayoutOnSafeAreaChanges = true
        setupTableFunction()

        node.layoutSpecBlock = { _, _ in
            let tableNodeStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 16, justifyContent: .start,
                alignItems: .stretch,
                children: [self.vehicleTextNode, self.vehicleTableNode]
            )
            tableNodeStack.style.flexGrow = 1

            let pageStack = ASStackLayoutSpec(
                direction: .vertical,
                spacing: 32,
                justifyContent: .start,
                alignItems: .start,
                children: [self.profileInfo, tableNodeStack]
            )

            return ASInsetLayoutSpec(insets: UIEdgeInsets(top: .topSafeArea, left: 16, bottom: 0, right: 16), child: pageStack)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        node.backgroundColor = .white
    }

    // MARK: - Functionality

    private func setupTableFunction() {
        profileInfo.ProfileBackground.delegate = self
        vehicleTableNode.delegate = self
        vehicleTableNode.dataSource = self
        vehicleTableNode.view.separatorStyle = .none
        vehicleTableNode.view.showsVerticalScrollIndicator = false
    }
}

extension UserProfileViewController: ASTableDelegate, ASTableDataSource {
    func tableNode(_: ASTableNode, numberOfRowsInSection _: Int) -> Int {
        guard let vehicle = vehicle else { return 1 }
        return vehicle.count + 1
    }

    func tableNode(_: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.row == vehicle?.count {
            return VehicleCellNode(model: nil)
        } else {
            return VehicleCellNode(model: vehicle?[indexPath.row] ?? nil)
        }
    }

    func tableNode(_: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == vehicle!.count {
            print("Add new selected")
        } else {
            print("vehicle[\(indexPath.row)] selected")
        }
    }
}

extension UserProfileViewController: ProfileBackgroundCardDelegate {
    func didTapEdit() {
        let vc = EditProfileContoller(profile: profile)
        navigationController?.present(vc, animated: true, completion: {
            // TODO: - Edit Done Action
        })
        print("editTapped")
    }
}
