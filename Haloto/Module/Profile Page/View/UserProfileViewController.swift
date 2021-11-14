//
//  UserProfileViewController.swift
//  Haloto
//
//  Created by Gratianus Martin on 11/4/21.
//

import AsyncDisplayKit
import Foundation
import RxCocoa
import RxSwift
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
    private var personalVehicle: [Vehicle]?

    // MARK: - ViewModel

    private var userProfileViewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()

    // MARK: - Initializer (Required)

    override init() {
        profile = dataDummy().profile
        personalVehicle = [dataDummy().vehicle, dataDummy().vehicle, dataDummy().vehicle, dataDummy().vehicle]
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
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //TODO: view model.requestData
    }

    // MARK: - Functionality

    private func setupTableFunction() {
        profileInfo.ProfileBackground.delegate = self
        vehicleTableNode.delegate = self
        vehicleTableNode.dataSource = self
        vehicleTableNode.view.separatorStyle = .none
        vehicleTableNode.view.showsVerticalScrollIndicator = false
    }

    // MARK: - Bindings

    func setupBindings() {
        userProfileViewModel
            .profile
            .asObservable()
            .subscribe { profile in
                self.profile = profile
            }
            .disposed(by: disposeBag)
        
        userProfileViewModel
            .personalVehicle
            .asObservable()
            .subscribe { vehicles in
                self.personalVehicle = vehicles
            }
            .disposed(by: disposeBag)
    }
}

extension UserProfileViewController: ASTableDelegate, ASTableDataSource {
    func tableNode(_: ASTableNode, numberOfRowsInSection _: Int) -> Int {
        guard let personalVehicle = personalVehicle else { return 1 }
        return personalVehicle.count + 1
    }

    func tableNode(_: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        if indexPath.row == personalVehicle?.count {
            return VehicleCellNode(model: nil)
        } else {
            return VehicleCellNode(model: personalVehicle?[indexPath.row] ?? nil)
        }
    }

    func tableNode(_: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == personalVehicle!.count {
            print("Add new selected")
            // TODO: Push Add new vehicle
        } else {
            if let vehicle = personalVehicle?[indexPath.row] {
                // TODO: Push Edit Vehicle
            }
        }
    }
}

extension UserProfileViewController: ProfileBackgroundCardDelegate {
    func didTapEdit() {
        let vc = EditProfileContoller(profile: profile)
        let bottomSheetVC = BottomSheetViewController(wrapping: vc)
        navigationController?.present(bottomSheetVC, animated: true, completion: nil)
    }
}
